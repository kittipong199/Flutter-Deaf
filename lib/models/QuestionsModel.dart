// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

// import 'package:meta/meta.dart';
import 'dart:convert';

List<QuestionsModel> questionsModelFromJson(String str) => List<QuestionsModel>.from(json.decode(str).map((x) => QuestionsModel.fromJson(x)));

String questionsModelToJson(List<QuestionsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionsModel {
    int id;
    int coureId;
    String questionText;
    String questionVideo;
    QuestionsModel({
        required this.id,
        required this.coureId,
        required this.questionText,
        required this.questionVideo,
    });

   

    factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        id: json["id"],
        coureId: json["coure_id"],
        questionText: json["questionText"] == null ? '' : json["questionText"],
        questionVideo: json["questionVideo"] == null ? '' : json["questionVideo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "coure_id": coureId,
        "questionText": questionText == null ? null : questionText,
        "questionVideo": questionVideo == null ? null : questionVideo,
    };
}
