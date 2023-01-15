// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';
import 'dart:math';

import 'package:app_deaf/models/answerModel.dart';
import 'package:app_deaf/models/question_Model.dart';
import 'package:app_deaf/pages/video_quiz.dart';
import 'package:app_deaf/utils/app_constarts.dart';
import 'package:app_deaf/widget/widget_image_youtube.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:app_deaf/models/Coures.dart';
import 'package:get/get.dart';

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

  var questionModels = <QuestionModel>[];

  var listAnswerModels = <List<AnswerModel>>[];
  var AnswersList = <List>[];
  var corrects = <int?>[];

  var trueCorrects = <int>[];

  var listCorrectBool = <List<bool>>[];

  var random = Random();

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

          int indexTrue = 0;

          String urlApiAnswer =
              'https://www.androidthai.in.th/fluttertraining/getAnswerWhereIdQuestionId.php?isAdd=true&question_id=${model.id}';

          await Dio().get(urlApiAnswer).then((value) {
            for (var element in json.decode(value.data)) {
              AnswerModel answerModel = AnswerModel.fromMap(element);
              answerModels.add(answerModel);
              correctBool.add(false);

              if (answerModel.correct.isNotEmpty) {
                trueCorrects.add(indexTrue);
              }
              indexTrue++;
            }
          });

          listAnswerModels.add(answerModels);
          listCorrectBool.add(correctBool);

          corrects.add(null);
        }
      }
      print('trueCorrects ---> $trueCorrects');
      setState(() {});
    });
  }
  
  @override
  Widget build(BuildContext context) {
    //  listAnswerModels.shuffle();
    return Scaffold(
      
      appBar: AppBar(
        title: Text('ข้อสอบ${couresModel!.couresname}'),
        actions: [
          IconButton(
            onPressed: () {
              bool status = true;
              print('corrects --> $corrects');
              print('truecorrects --> $trueCorrects');
              for (var element in corrects) {
                if (element == null) {
                  status = false;
                }
              }

              if (status) {
                int score = 0;
                for (var i = 0; i < corrects.length; i++) {
                  if (corrects[i] == trueCorrects[i]) {
                    score++;
                  }
                }
                Get.snackbar('Score: $questionModels.',  '$score คะแนน',
                    snackPosition: SnackPosition.BOTTOM);
              } else {
                print('ตอบไม่ครบ');
                Get.snackbar('ทำไม่ครบ', 'กรุณาทำใหม่ให้ครบ ข้อ',
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            icon: const Icon(Icons.send_outlined),
          )
        ],
      ),
      body: load
          ? Center(child: CircularProgressIndicator())
          : haveData!
              ? ListView.builder(
                
                  itemCount: questionModels.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Card(
                        color: Color(0xFFFFB200),
                        
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Row(
                              
                              crossAxisAlignment: CrossAxisAlignment.center,
                              
                              children: [
                                
                                Text(
                                  (index + 1).toString(),
                                  style: AppConstart().h1Style(),
                                ),
                                contentQuestion(index).marginOnly(right: 10,left: 20),
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Text('question ==. ${questionModels[index].id}')


                      Card(
                        
                        color: Color.fromARGB(255, 108, 184, 158),
                        child: Container(
                        
                          child: ListView.builder(
                            
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            // กำหนดให้ คำตอบมี มากสุดได้ 4 ข้อ
                            itemCount: listAnswerModels[index].length = 4 ,
                           
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
                                  ? Text(listAnswerModels[index][index2].answerText,textAlign: TextAlign.start,)
                                  : WidgetImageYoutube(
                                      urlYoutube: listAnswerModels[index][index2]
                                          .answerVideo,
                                      width: 100,
                                      height: 70,
                                    ),
                            ),
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
