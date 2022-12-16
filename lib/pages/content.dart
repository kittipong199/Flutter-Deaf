import 'package:app_deaf/routers.dart';
import 'package:flutter/material.dart';

import 'package:app_deaf/models/ContentModel.dart';
// import 'package:app_deaf/models/post.dart';
import 'package:app_deaf/service/contentApi.dart' show ContentsApi;

import 'package:animation_search_bar/animation_search_bar.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {

  late TextEditingController controller;
   Future<List<ContentModel>>? futureContent;
  @override
  void initState() {
    super.initState();
    futureContent = ContentsApi.futureContentApi();

    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 65),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0xFFFFB200),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(255, 247, 244, 244),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: Offset(0, 5))
                ]),
            alignment: Alignment.center,
            child: AnimationSearchBar(
                backIconColor: Colors.black,
                centerTitle: 'บทเรียน',
                onChanged: (text) => debugPrint(text),
                searchTextEditingController: controller,
                horizontalPadding: 5),
          ),
        ),
      ),
      // body listview
      body: FutureBuilder<List<ContentModel>>(
          future: futureContent,
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
                        onTap:_handleCilkContentVideo,
                       

                        child: Padding(
                          padding: const EdgeInsets.all(20.6),
                          child: Column(
                            children: [
                           
                             
                              Text(snapshot.data![index].contentname.toString()
                              ,style: TextStyle(fontSize: 20.0,),
                              )
                            
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
     void _handleCilkContentVideo() {
     Navigator.pushNamed(context, AppRoute.content_video);
      // Navigator.pushNamed(context, AppRoute.navbars);
  }
  
}