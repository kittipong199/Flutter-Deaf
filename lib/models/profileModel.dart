// To parse this JSON data, do
//
//     final ProfileModel = loginModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<ProfileModel> ProfileModelFromJson(String str) =>
    List<ProfileModel>.from(json.decode(str).map((x) => ProfileModel.fromJson(x)));

String ProfileModelToJson(List<ProfileModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  String id;
  String userName;
  String passwords;
  String images;

  ProfileModel({
    required this.id,
    required this.userName,
    required this.passwords,
    required this.images,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        userName: json["user_name"],
        passwords: json["passwords"],
        images: json["images"] == null ? '' : json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "passwords": passwords,
        "images": images == null ? null : images,
      };

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'passwords': passwords,
      'images': images ,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: (map['id'] ?? '') as String,
      userName: (map['user_name'] ?? '') as String,
      passwords: (map['passwords'] ?? '') as String,
      images: (map['image'] ?? '') as String,
    );
  }
}
