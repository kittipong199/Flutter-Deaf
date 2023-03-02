// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {

    String id;
    String userId;
    String contentId;
    String contentname;
    String video;

    HistoryModel({
        required this.id,
        required this.userId,
        required this.contentId,
        required this.contentname,
        required this.video,
    });


    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        userId: json["user_id"],
        contentId: json["content_id"],
        contentname: json["contentname"],
        video: json["video"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content_id": contentId,
        "contentname": contentname,
        "video": video,
    };



  Map<String, dynamic> toMap() {
      return <String, dynamic>{
        "id": id,
        "user_id": userId,
        "content_id": contentId,
        "contentname": contentname,
        "video": video,
    };
    }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: (map['id'] ?? '') as String,
      userId: (map['userId'] ?? '') as String,
      contentId: (map['contentId'] ?? '') as String,
      contentname: (map['contentname'] ?? '') as String,
      video: (map['video'] ?? '') as String,
     
    );
  }


}
