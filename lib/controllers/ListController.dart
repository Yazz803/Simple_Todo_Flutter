// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_todo/config/api.dart';
import 'package:simple_todo/models/ListModel.dart';

class ListController extends GetxController {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  bool isLoading = true;
  bool isLoadingAdd = false;
  bool isLoadingEdit = false;
  bool isLoadingDelete = false;
  List<ListModel> list = [];

  @override
  void onInit() {
    super.onInit();
    getLists();
  }

  Future<void> getLists() async {
    isLoading = true;
    update();
    var result = await Api.getRequest('/api/lists');
    if (result['success']) {
      list = List<ListModel>.from(
          result['data'].map((i) => ListModel.fromJson(i)));
    }
    isLoading = false;
    update();
  }

  Future<void> addList() async {
    isLoadingAdd = true;
    update();
    print('title: ${title.text}');
    print('desc: ${desc.text}');
    var result = await Api.postRequest('/api/lists/add', {
      'title': title.text,
      'desc': desc.text,
    });
    if (result['success']) {
      getLists();
      title = TextEditingController();
      desc = TextEditingController();
    } else {
      print(result['message'] ?? 'Unknown Error');
    }

    isLoadingAdd = false;
    update();
  }

  Future<void> editList(int id) async {
    isLoadingEdit = true;
    update();
    print('title: ${title.text}');
    print('desc: ${desc.text}');
    var result = await Api.putRequest('/api/lists/update', {
      'id': id.toString(),
      'title': title.text,
      'desc': desc.text,
    });
    if (result['success']) {
      getLists();
      title = TextEditingController();
      desc = TextEditingController();
    } else {
      print(result['message'] ?? 'Unknown Error');
    }

    isLoadingEdit = false;
    update();
  }
}
