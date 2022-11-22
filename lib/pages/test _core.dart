import 'package:flutter/material.dart';

class test_core extends StatefulWidget {
  const test_core({super.key});

  @override
  State<test_core> createState() => _HomaPageState();
}

class _HomaPageState extends State<test_core> {
  int navindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFFFB200),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB200),
        title: Text("คะเเนนทดสอบ"),
      ),

      body: Center(
        child: Container(
          // btn เริ่มเรียน
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // image logo

              Center(
                  child: Text(
                "คะเเนน",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
             ),
              SizedBox(
                height: 150,
              ),
              //  btn เริ่มเรียน
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF277BC0),
                    shape: const StadiumBorder(),

                    minimumSize: Size(120, 50), // background

                    // foreground
                  ),
                  onPressed: () {},
                  child: const Text(
                    "ทดสอบอีกครั้ง",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF277BC0),
                    shape: const StadiumBorder(),

                    minimumSize: Size(120, 50), // background

                    // foreground
                  ),
                  onPressed: () {},
                  child: const Text(
                    "เช็คคำตอบอีกครั้ง",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
