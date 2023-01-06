// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:app_deaf/models/answerModel.dart';
import 'package:app_deaf/models/question_Model.dart';
import 'package:app_deaf/utils/app_constarts.dart';
import 'package:app_deaf/widget/widget_image_youtube.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:app_deaf/models/Coures.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({
    Key? key,
    required this.coureModel,
  }) : super(key: key);
  final Coures coureModel;

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Coures? couresModel;

  bool load = true;
  bool? haveData;

  bool? test;
  var questionModels = <QuestionModel>[];

  var listAnswerModels = <List<AnswerModel>>[];

  var corrects = <int?>[];

  var listCorrectBool = <List<bool>>[];
  @override
  void initState() {
    super.initState();
    couresModel = widget.coureModel;

    readQuestion();
  }

  Future<void> readQuestion() async {
    String UrlApi =
        "https://www.androidthai.in.th/fluttertraining/getQuestionWhereIdCourseUng.php?isAdd=true&coure_id=${couresModel!.id}";

    await Dio().get(UrlApi).then((value) async {
      load = false;
      if (value.toString() == 'null') {
        haveData = false;
      } else {
        haveData = true;

        for (var element in json.decode(value.data)) {
          QuestionModel model = QuestionModel.fromMap(element);

          questionModels.add(model);

          var answerModels = <AnswerModel>[];

          var correctBool = <bool>[];

          String urlApiAnswer =
              'https://www.androidthai.in.th/fluttertraining/getAnswerWhereIdQuestionId.php?isAdd=true&question_id=${model.id}';

          await Dio().get(urlApiAnswer).then((value) {
            for (var element in json.decode(value.data)) {
              AnswerModel answerModel = AnswerModel.fromMap(element);
              answerModels.add(answerModel);
              correctBool.add(false);
            }
          });

          listAnswerModels.add(answerModels);
          listCorrectBool.add(correctBool);

          corrects.add(null);
        }
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อสอบ${couresModel!.couresname}'),
      ),
      body: load
          ? Center(child: CircularProgressIndicator())
          : haveData!
              ? ListView.builder(
                  itemCount: questionModels.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (index + 1).toString(),
                            style: AppConstart().h1Style(),
                          ),
                          contentQuestion(index),
                        ],
                      ),
                      // Text('question ==. ${questionModels[index].id}')
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: listAnswerModels[index].length,
                        itemBuilder: (context, index2) => RadioListTile(
                          value: index2,
                          groupValue: corrects[index],
                          onChanged: (value) {
                            corrects[index] = value!;

                            print('value is ${corrects}');
                            setState(() {});
                          },
                          title: listAnswerModels[index][index2]
                                  .answerText
                                  .isNotEmpty
                              ? Text(listAnswerModels[index][index2].answerText)
                              : WidgetImageYoutube(
                                  urlYoutube: listAnswerModels[index][index2]
                                      .answerVideo,
                                  width: 100,
                                  height: 70,
                                ),
                        ),
                      ),
                      Divider(
                        color: AppConstart.darkColor,
                        thickness: 1,
                      )
                    ],
                  ),
                )
              : const Text('no data'),
    );
  }

  StatelessWidget contentQuestion(int index) {
    return questionModels[index].questionText.isNotEmpty
        ? Text(
            questionModels[index].questionText,
            style: AppConstart().h1Style(),
          )
        : WidgetImageYoutube(
            urlYoutube: questionModels[index].questionVideo,
            width: 180,
            height: 130,
          );
  }
}
