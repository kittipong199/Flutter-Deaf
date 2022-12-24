// import 'package:app_deaf/service/remote_service.dart';

import 'dart:developer';

import 'package:app_deaf/routers.dart';
import 'package:flutter/material.dart';
import 'package:app_deaf/models/Coures.dart';
// import 'package:app_deaf/models/post.dart';
import 'package:app_deaf/service/couresApi.dart' show CouresApi;

import 'package:animation_search_bar/animation_search_bar.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class CouresPage extends StatefulWidget {
  const CouresPage({super.key});

  @override
  State<CouresPage> createState() => _CouresPageState();
}

class _CouresPageState extends State<CouresPage> {
  late TextEditingController controller;

  Future<List<Coures>>? futureCoures;
  @override
  void initState() {
    super.initState();
    futureCoures = CouresApi.futureCouresApi();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // mock call api

    return Scaffold(
      //appbar
      //  appBar: PreferredSize(
      //   preferredSize: const Size(double.infinity, 65),
      //   child: SafeArea(
      //     child: Container(
      //       decoration: const BoxDecoration(
      //           color: Color(0xFFFFB200),
      //           boxShadow: [
      //             BoxShadow(
      //                 color: Color.fromARGB(255, 247, 244, 244),
      //                 blurRadius: 5,
      //                 spreadRadius: 0,
      //                 offset: Offset(0, 5))
      //           ]),
      //       alignment: Alignment.center,
      //       child: AnimationSearchBar(
      //           backIconColor: Colors.black,
      //           centerTitle: 'หมวดหมู่',
      //           onChanged: (text) => debugPrint(text),
      //           searchTextEditingController: controller,
      //           horizontalPadding: 5),
      //     ),
      //   ),
      // ),
      // body listview
      body: FutureBuilder<List<Coures>>(
          future: futureCoures,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //List<Coures> coures = snapshot.data;
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shadowColor: Color.fromARGB(220, 6, 6, 6),
                      color: Color(0xFFFFB200),
                      child: InkWell(
                        // กดไปหน้า content
                        onTap: _handleCilkContent,
                        child: Padding(
                          padding: const EdgeInsets.all(20.6),
                          child: Column(
                            children: [
                              Text(snapshot.data![index].couresname.toString()),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          }),
    );
  }
   void _handleCilkContent() {
     Navigator.pushNamed(context, AppRoute.contents);
      // Navigator.pushNamed(context, AppRoute.navbars);
  }
}
