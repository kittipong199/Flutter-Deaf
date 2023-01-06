import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AnswerModel {

    final String id;
    final String question_id;
    final String answerText;
    final String answerVideo;
    final String correct;
  AnswerModel({
    required this.id,
    required this.question_id,
    required this.answerText,
    required this.answerVideo,
    required this.correct,
  });

  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question_id': question_id,
      'answerText': answerText,
      'answerVideo': answerVideo,
      'correct': correct,
    };
  }

  factory AnswerModel.fromMap(Map<String, dynamic> map) {
    return AnswerModel(
      id: (map['id'] ?? '') as String,
      question_id: (map['question_id'] ?? '') as String,
      answerText: (map['answerText'] ?? '') as String,
      answerVideo: (map['answerVideo'] ?? '') as String,
      correct: (map['correct'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AnswerModel.fromJson(String source) => AnswerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
