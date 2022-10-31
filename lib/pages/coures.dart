
import 'package:flutter/material.dart';

class CouresPage extends StatefulWidget {
  const CouresPage({super.key});

  @override
  State<CouresPage> createState() => _CouresPageState();
}

class _CouresPageState extends State<CouresPage> {
  final List<String> listcoures = [
      "ทักทาย",
      "ตัวเลข",
      "สี",
      "วัน-เดือน-ปี",
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appbar
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB200),
        title: Text('หมวดหมู่'),
      ),

      // body listview
      body:  ListView.builder(
        
        itemCount: listcoures.length,
        itemBuilder: (context, index) {
          return Card(
            
            
            child: ListTile(
              // leading: CircleAvatar(
              //   backgroundColor: Colors.blue
               title: Center(
              child: Text(
              listcoures[index],
              
            ),
              ),
                ),

            // title: Center(
            //   child: Text(
            //   listcoures[index],
            // ),
            //   ),
            // ),
          );
        }
        ),
        
      
    );
  }
}