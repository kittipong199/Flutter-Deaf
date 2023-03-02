// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_deaf/models/historyModel.dart';
import 'package:flutter/material.dart';

import 'package:app_deaf/models/ContentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as dioapi;

import 'dart:convert' as convert;

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var searchHistoryModels = <HistoryModel>[];
  bool load = true;
  bool? haveData;
  String userId = '';
  var futureHistory = <HistoryModel>[];

  @override
  void initState() {
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString('id')!;
      checkHistory();
    });
  }

  Future<Null> checkHistory() async {
    var dio = dioapi.Dio();

    String urlapi =
        'http://sit.thonburi-u.ac.th/phpApi/getWherehistory.php?isAdd=true&user_id=${userId.toString()}';
    print('urlapiAPI history ---> ${urlapi.toString()}');

    await dio.get(urlapi).then((value) {
      // var bodys = convert.json.decode(response.data.toString());
      // print('resCheckUser == ${bodys}');
      if (value.toString() == 'null') {
        haveData = false;
      } else {
        haveData = true;
        for (var element in convert.json.decode(value.data)) {
          HistoryModel model = HistoryModel.fromMap(element);
          futureHistory.add(model);
        }
      }
      if (futureHistory.isNotEmpty) {
        searchHistoryModels.addAll(futureHistory);
      }
      print(
          'ขนาด searchContentModel --> ${searchHistoryModels.length}, haveData --> $haveData, data--> ${futureHistory}');

      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติการเรียน"),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints BoxConstraints) {
        return SizedBox(
          width: BoxConstraints.maxWidth,
          height: BoxConstraints.maxHeight,
          child: Stack(children: [mainContent()]),
        );
      }),
    );
  }

  Widget mainContent() {
    return load
        ? const Center(child: CircularProgressIndicator())
        : haveData!
            ? ListView.builder(
                itemCount: searchHistoryModels.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shadowColor: const Color.fromARGB(220, 6, 6, 6),
                    color: const Color(0xFFFFB200),
                    child: InkWell(
                      // กดไปหน้า content
                      onTap: () {
                        // _handleCilkContentVideo(
                        //     contentModel: searchHistoryModels[index]);
                        // addHistory();
                      },

                      child: Padding(
                        padding: const EdgeInsets.all(20.6),
                        child: Column(
                          children: [
                            Text(
                              searchHistoryModels[index].contentname.toString(),
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
}
