
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              tileColor: Color(0xFFFFB200),
              // leading: CircleAvatar(
              //   backgroundColor: Colors.blue
               title: Center(
              
              child: Text(
              listcoures[index], style: TextStyle(fontSize: 35,color: Color.fromARGB(255, 0, 0, 0)),
              //style: GoogleFonts.aBeeZee(textStyle:TextStyle(fontSize: 30,color: Color.fromARGB(255, 0, 0, 0)), )
              
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