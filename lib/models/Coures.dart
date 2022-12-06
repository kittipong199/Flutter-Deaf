// To parse this JSON data, do
//
//     final coures = couresFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

// Future<Coures> couresFromJson(String JsonData) async =>
//     Coures.fromJson(json.decode(JsonData));
Coures couresFromJson(String str) => Coures.fromJson(json.decode(str));
String couresToJson(Coures data) => json.encode(data.toJson());

class Coures {
  final int id;
  final String couresname;
  Coures({
    required this.id,
    required this.couresname,
  });

  

  factory Coures.fromJson(Map<String, dynamic> json) => Coures(
        id: json["id"],
        couresname: json["couresname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "couresname": couresname,
      };
}
