import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Api {
  static Future<Map<String, dynamic>> getRequest(String uri) async {
    final http.Response response = await http
        .get(Uri.https('simpletodo.loca.lt', uri), headers: {
      'Content-Type': 'application/json',
      'Bypass-Tunnel-Reminder': 'teuing naon'
    });

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> postRequest(
      String uri, Map<String, dynamic> body) async {
    final http.Response response = await http.post(
      Uri.https('simpletodo.loca.lt', uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Bypass-Tunnel-Reminder': 'teuing naon'
      },
      body: jsonEncode(body),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {;
      throw Exception(data['message'] ?? 'Unknown Error');
    }
  }

  static Future<Map<String, dynamic>> putRequest(
      String uri, Map<String, dynamic> body) async {
    final http.Response response = await http.put(
      Uri.https('simpletodo.loca.lt', uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Bypass-Tunnel-Reminder': 'teuing naon'
      },
      body: jsonEncode(body),
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Unknown Error');
    }
  }

  static Future<Map<String, dynamic>> deleteRequest(String uri) async {
    final http.Response response = await http.delete(
      Uri.https('simpletodo.loca.lt', uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Bypass-Tunnel-Reminder': 'teuing naon'
      },
    );

    final Map<String, dynamic> data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception(data['message'] ?? 'Unknown Error');
    }
  }
}
