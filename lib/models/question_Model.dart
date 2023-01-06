import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class QuestionModel {
  
  final String id;
  final String coure_id;
  final String questionText;
  final String questionVideo;
  QuestionModel({
    required this.id,
    required this.coure_id,
    required this.questionText,
    required this.questionVideo,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coure_id': coure_id,
      'questionText': questionText,
      'questionVideo': questionVideo,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: (map['id'] ?? '') as String,
      coure_id: (map['coure_id'] ?? '') as String,
      questionText: (map['questionText'] ?? '') as String,
      questionVideo: (map['questionVideo'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
