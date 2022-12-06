// import 'package:app_deaf/service/remote_service.dart';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:app_deaf/models/Coures.dart';
// import 'package:app_deaf/models/post.dart';
import 'package:app_deaf/service/couresApi.dart';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

class CouresPage extends StatefulWidget {
  const CouresPage({super.key});

  @override
  State<CouresPage> createState() => _CouresPageState();
}

class _CouresPageState extends State<CouresPage> {
  // CallAPI Service
  // late CouresApi couresAPI;
  // late Future<Future<Coures>?> futureCoures;
  // List _data = [];
  // Future<String> getData() async {
  //   final url =
  //       Uri.https('http://10.0.2.2:8000/api', '/couresname', {'q': '{http}'});

  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final jsonResponse = convert.jsonDecode(response.body);
  //     final jsonString = jsonEncode(object)
  //     print(jsonResponse);
  //     this.setState(() {
  //       _data = jsonResponse;
  //       log("ok");
  //     });
  //   }
  //   return 'success';
  // }

  // สร้าง context

  // late BuildContext context;

  // @override
  // void initState() {
  //   // super.initState();
  //   // couresAPI = CouresApi();
  //   getData();
  // }

  late Future<List<Coures>> futureCoures;
  @override
  void initState() {
    super.initState();
    futureCoures = futureCoures;
  }

  @override
  Widget build(BuildContext context) {
    // mock call api

    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB200),
        title: Text('หมวดหมู่'),
      ),

      // body listview

      body: FutureBuilder<List<Coures>>(
          future: futureCoures,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Coures>? coures = snapshot.data;
              return ListView.builder(
                  itemCount: coures!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shadowColor: Color.fromARGB(220, 6, 6, 6),
                      color: Color(0xFFFFB200),
                      child: InkWell(
                        // กดไปหน้า content
                        onTap: () {
                          print('next');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.6),
                          child: Column(
                            children: [
                              Text(snapshot.data![index].couresname),
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
}
