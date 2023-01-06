// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);
import 'dart:convert';

List<ContentModel> contentModelFromJson(String str) => List<ContentModel>.from(json.decode(str).map((x) => ContentModel.fromJson(x)));

String contentModelToJson(List<ContentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContentModel {

    String id;
    String coureId;
    String contentname;
    String video;
    String image;
    String contentText;

    ContentModel({
        required this.id,
        required this.coureId,
        required this.contentname,
        required this.video,
        required this.image,
        required this.contentText,
    });

 
    factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        coureId: json["coure_id"],
        contentname: json["contentname"],
        video: json["video"],
        image: json["image"] == null ? '' : json["image"],
        contentText: json["content_text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coure_id": coureId,
        "contentname": contentname,
        "video": video,
        "image": image == null ? null : image,
        "content_text": contentText,
    };

  

 

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coureId': coureId,
      'contentname': contentname,
      'video': video,
      'image': image,
      'contentText': contentText,
    };
  }

  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      id: (map['id'] ?? '') as String,
      coureId: (map['coureId'] ?? '') as String,
      contentname: (map['contentname'] ?? '') as String,
      video: (map['video'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      contentText: (map['contentText'] ?? '') as String,
    );
  }

 
}
