// import 'package:app_deaf/service/remote_service.dart';
import 'package:app_deaf/models/post.dart';
import 'package:flutter/material.dart';

// import 'package:app_deaf/models/post.dart';
import 'package:http/http.dart' as http;

class CouresPage extends StatefulWidget {
  const CouresPage({super.key});

  @override
  State<CouresPage> createState() => _CouresPageState();
}

class _CouresPageState extends State<CouresPage> {
  // var isLoaded() => false;
  // late Future<Coures> AllCoures;
  final List<String> listcoures = [
    "ทักทาย",
    "ตัวเลข",
    "สี",
    "วัน-เดือน-ปี",
  ];
  // @override
  // void initState() {
  //   super.initState();
  //   getCouresApi();
  //   // AllCoures = AllCoures();
  // }
  //   // async  ดึงข้อมูล
  // Future <void> getCouresApi() async {
  //   var url = Uri.parse('http://localhost:8000/api/couresname');
  //   var response = await http.get(url); // รอดึงข้อมูลมาจนเสร็จ ถึงจะแสดงได้
  //   print(response.body);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB200),
        title: Text('หมวดหมู่'),
      ),

      // body listview

      body: ListView.builder(
          itemCount: listcoures.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                tileColor: Color(0xFFFFB200),
                // leading: CircleAvatar(
                //   backgroundColor: Colors.blue
                title: Center(
                    child: FutureBuilder<Coures>(
                  // future: AllCoures,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        snapshot.data!.couresname,

                        style: TextStyle(
                            fontSize: 35, color: Color.fromARGB(255, 0, 0, 0)),
                        //style: GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 30,color: Color.fromARGB(255, 0, 0, 0)), )
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                )),
              ),

              // title: Center(
              //   child: Text(
              //   listcoures[index],
              // ),
              //   ),
              // ),
            );
          }),
    );
  }
}
