// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert' as convert;
import 'dart:developer';

import 'package:animation_search_bar/animation_search_bar.dart';
import 'package:app_deaf/models/historyModel.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dioApi hide FormData;
import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/models/Coures.dart';
import 'package:app_deaf/pages/question/question_page.dart';
import 'package:app_deaf/pages/video_youtube.dart';

import 'package:app_deaf/service/contentApi.dart' show ContentsApi;
import 'package:shared_preferences/shared_preferences.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({
    Key? key,
    required this.couresModel,
  }) : super(key: key);

  final Coures couresModel;

  get contentId => contentId;

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
  String userId = '';
  @override
  void initState() {
    super.initState();
    futureContent =
        ContentsApi.futureContentApi(couresModel: widget.couresModel);

    controller = TextEditingController();
    findUser();
    readContentFromCouceId();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString('id')!;
    });
  }

  Future<void> readContentFromCouceId() async {
    String urlApi =
        'http://sit.thonburi-u.ac.th/phpApi/getContentWhereIdCourseUng.php?isAdd=true&coure_id=${widget.couresModel.id}';

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
      print(
          'ขนาด searchContentModel --> ${searchContentModels.length}, haveData --> $haveData');

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

                        checkHisto(contentModel: searchContentModels[index]);
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
    Get.to(VideoYoutube(
      contentModel: contentModel,
    ));
  }

  Future<Null> checkHisto({required ContentModel contentModel}) async {
    String conid = contentModel.id;
    var dio = dioApi.Dio();
    String addHistoryApi =
        'http://sit.thonburi-u.ac.th/phpApi/checkhistory.php?isAdd=true&user_id=${userId.toString()}&content_id=${conid}';
    try {
      var response = await dio.get(addHistoryApi);
      var bodys = convert.json.decode(response.data.toString());
      log('resCheckhistory == ${bodys}');
      if (bodys == null) {
        print('ไม่เคยดู');
        addHistory(contentModel: conid);
      } else {
        for (var map in bodys) {
          HistoryModel historyModel = HistoryModel.fromJson(map);
          if (userId == historyModel.contentId &&
              conid == historyModel.contentId) {
            print('มีข้อมูลแล้ว');
          } 
        }
      }
    } catch (e) {}
  }

  void addHistory({required contentModel}) async {
    // String conid = contentModel.id;
    var dio = dioApi.Dio();
    String addHistoryApi =
        'http://sit.thonburi-u.ac.th/phpApi/history.php?isAdd=true&user_id=${userId.toString()}&content_id=${contentModel}';
    try {
      var response = await dio.get(addHistoryApi);
      var bodys = convert.json.decode(response.data.toString());
      print('res add History == ${bodys}');
    } catch (e) {}
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
