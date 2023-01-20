// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert' as convert;

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:app_deaf/pages/question/question_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/models/Coures.dart';
import 'package:app_deaf/pages/video_youtube.dart';
import 'package:app_deaf/routers.dart';
import 'package:app_deaf/service/contentApi.dart' show ContentsApi;

class ContentPage extends StatefulWidget {
  const ContentPage({
    Key? key,
    required this.couresModel,
  }) : super(key: key);

  final Coures couresModel;

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  late TextEditingController controller;
  Future<List<ContentModel>>? futureContent;

  final debouncer = Debouncer(milliSecond: 500);
  var contentModels = <ContentModel>[];
  // for search
  var searchContentModels = <ContentModel>[];
  bool load = true;
  bool? haveData;

  @override
  void initState() {
    super.initState();
    futureContent =
        ContentsApi.futureContentApi(couresModel: widget.couresModel);

    controller = TextEditingController();

    readContentFromCouceId();
  }

  Future<void> readContentFromCouceId() async {
    String urlApi =
        'https://www.androidthai.in.th/fluttertraining/getContentWhereIdCourseUng.php?isAdd=true&coure_id=${widget.couresModel.id}';

    print('urlAPI ---> $urlApi');
    await Dio().get(urlApi).then((value) {
      if (value.toString() == 'null') {
        haveData = false;
      } else {
        haveData = true;

        for (var element in convert.json.decode(value.data)) {
          ContentModel model = ContentModel.fromMap(element);
          contentModels.add(model);
        }
      }
      if (contentModels.isNotEmpty) {
        searchContentModels.addAll(contentModels);
      }
      print('ขนาด searchContentModel --> ${searchContentModels.length}, haveData --> $haveData');
          
      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 65),
        child: SafeArea(
          child: Container(
            decoration:
                const BoxDecoration(color: Color(0xFFFFB200), boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 247, 244, 244),
                  blurRadius: 5,
                  spreadRadius: 0,
                  offset: Offset(0, 5))
            ]),
            alignment: Alignment.center,
            child: load
                ? const SizedBox()
                : haveData!
                    ? AnimationSearchBar(
                        backIconColor: Colors.black,
                        centerTitle: 'บทเรียน',
                        onChanged: (text) {
                          debugPrint(text);

                          debouncer.run(() {
                            if (searchContentModels.isNotEmpty) {
                              searchContentModels.clear();

                              searchContentModels.addAll(contentModels);
                            }

                            searchContentModels = searchContentModels
                                .where((element) => element.contentname
                                    .toLowerCase()
                                    .contains(text.trim().toLowerCase()))
                                .toList();

                            setState(() {});
                          });
                        },
                        searchTextEditingController: controller,
                        horizontalPadding: 5)
                    : Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_back)),
                          Text('ไม่มีบทเรียน'),
                        ],
                      ),
          ),
        ),
      ),
      // body listview
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return SizedBox(
          width: boxConstraints.maxWidth,
          height: boxConstraints.maxHeight,
          child: Stack(
            // fit: StackFit.expand,
            children: [
              mainContent(),
              Positioned(
                bottom: 0,
                right: 16,
                left: 16,
                child: ElevatedButton(
                  onPressed: () {
                    print("you click coure_id == > ${widget.couresModel.id}");

                    Get.to(QuestionPage(coureModel: widget.couresModel));
                  },
                  child: Text("ทดสอบ"),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget mainContent() {
    return load
        ? const Center(child: CircularProgressIndicator())
        : haveData!
            ? ListView.builder(
                itemCount: searchContentModels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shadowColor: const Color.fromARGB(220, 6, 6, 6),
                    color: const Color(0xFFFFB200),
                    child: InkWell(
                      // กดไปหน้า content
                      onTap: () {
                        _handleCilkContentVideo(
                            contentModel: searchContentModels[index]);
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(20.6),
                        child: Column(
                          children: [
                            Text(
                              searchContentModels[index].contentname.toString(),
                              style: const TextStyle(
                                fontSize: 20.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
            : Center(child: const Text('ยังไม่มี บทเรียน'));
  }

  void _handleCilkContentVideo({required ContentModel contentModel}) {
    // Navigator.pushNamed(context, AppRoute.content_video);
    // Navigator.pushNamed(context, AppRoute.navbars);

    Get.to(VideoYoutube(
      contentModel: contentModel,
    ));
  }
}

class Debouncer {
  final int milliSecond;
  Timer? timer;
  VoidCallback? voidCallback;
  Debouncer({
    required this.milliSecond,
    this.timer,
    this.voidCallback,
  });

// สั่งเล่น Video และ ให้หยุดเล่นเมื่อกดกลับ
  run(VoidCallback voidCallback) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(Duration(milliseconds: milliSecond), voidCallback);
  }
}
