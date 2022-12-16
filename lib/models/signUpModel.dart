// To parse this JSON data, do
//
//     final registorModel = registorModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<RegistorModel> registorModelFromJson(String str) => List<RegistorModel>.from(json.decode(str).map((x) => RegistorModel.fromJson(x)));

String registorModelToJson(List<RegistorModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegistorModel {

    String userName;
    String passwords;
    RegistorModel({
        required this.userName,
        required this.passwords,
    });

  

    factory RegistorModel.fromJson(Map<String, dynamic> json) => RegistorModel(
        userName: json["user_name"],
        passwords: json["passwords"],
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "passwords": passwords,
    };
}
