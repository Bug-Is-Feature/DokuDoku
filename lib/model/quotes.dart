import 'dart:convert';

List<TextModel> textModelFromJson(String str) =>
    List<TextModel>.from(json.decode(str).map((x) => TextModel.fromJson(x)));

String textModelToJson(List<TextModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TextModel {
  TextModel({
    required this.q,
    required this.a,
    required this.c,
    required this.h,
  });

  String q;
  String a;
  String c;
  String h;

  factory TextModel.fromJson(Map<String, dynamic> json) => TextModel(
        q: json["q"],
        a: json["a"],
        c: json["c"],
        h: json["h"],
      );

  Map<String, dynamic> toJson() => {
        "q": q,
        "a": a,
        "c": c,
        "h": h,
      };
}
