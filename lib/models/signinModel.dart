// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<LoginModel> loginModelFromJson(String str) =>
    List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));

String loginModelToJson(List<LoginModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LoginModel {
  String? id;
  String? userName;
  String? passwords;
  dynamic images;

  LoginModel({
    required this.id,
    required this.userName,
    required this.passwords,
    required this.images,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        userName: json["user_name"],
        passwords: json["passwords"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "passwords": passwords,
        "images": images,
      };

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'passwords': passwords,
      'images': images,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: (map['id'] ?? '') as String,
      userName: (map['user_name'] ?? '') as String,
      passwords: (map['passwords'] ?? '') as String,
      images: (map['image'] ?? '') as String,
    );
  }
}
