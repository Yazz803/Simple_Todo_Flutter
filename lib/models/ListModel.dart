// To parse this JSON data, do
//
//     final listModel = listModelFromJson(jsonString);

import 'dart:convert';

List<ListModel> listModelFromJson(String str) => List<ListModel>.from(json.decode(str).map((x) => ListModel.fromJson(x)));

String listModelToJson(List<ListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListModel {
    int id;
    String title;
    String desc;
    DateTime createdAt;
    DateTime updatedAt;

    ListModel({
        required this.id,
        required this.title,
        required this.desc,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
