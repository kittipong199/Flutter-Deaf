// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) => List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
    String userName;
    String passwords;
    LoginModel({
        required this.userName,
        required this.passwords,
    });

   

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        userName: json["user_name"],
        passwords: json["passwords"],
    );

    Map<String, dynamic> toJson() => {
        "user_name": userName,
        "passwords": passwords,
    };
}
