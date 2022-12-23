import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfliePage extends StatefulWidget {
  const ProfliePage({super.key});

  @override
  State<ProfliePage> createState() => _ProfliePageState();
}

class _ProfliePageState extends State<ProfliePage> {
  final ImagePicker _imagePicker = ImagePicker();
  final file = File;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: Text(
          "โปรไฟล์",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xFFFFB200),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
      ),

      //body
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Text(
              "โปรไฟล์ของคุณ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 15,
            ),

            Center(
              // child: Stack(
              //   children: [
              //     CircleAvatar(

              //     foregroundImage: AssetImage('assets/images/logo.jpg'),
              //   ),

              // this show image Profile
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: file == null ? AssetImage('assets/images/logo.jpg') : Image.file(file)
                           
                            
                            )),
                  ),

                  //bottom change image and edit
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.green,
                        ),
                        child: InkWell(
                          onTap: () =>  chooseImage(ImageSource.camera),
                          child: Icon(
                            // icon: Icon(
                            //   Icons.edit,
                            // ),
                            // onPressed: () => chooseImage(ImageSource.camera),
                             Icons.edit,
                           color: Colors.white,
                          ),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            // Text
            Center(
                child: Text(
              "ชื่อของคุณ",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 100,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF277BC0),
                  shape: const StadiumBorder(),

                  minimumSize: Size(120, 50), // background

                  // foreground
                ),
                onPressed: () {},
                child: Text(
                  'เปลี่ยนรหัสผ่าน',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ))
          ],
        ),
      ),
    );
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    
    try {
      var object = await ImagePicker.platform
          .pickImage(source: imageSource, maxHeight: 800.0, maxWidth: 800.0);

      setState(() {
        var file = object;
      });
    } catch (e) {
      print("Error is:,${e}");
    }
  }
}
