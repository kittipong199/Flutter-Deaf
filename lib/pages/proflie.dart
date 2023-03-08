import 'dart:developer';
import 'dart:io';
import 'dart:convert' as convert;
import 'package:app_deaf/controller/image_controller.dart';
import 'package:app_deaf/models/profileModel.dart';
import 'package:app_deaf/models/signinModel.dart';
import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/signin_signup/reset_password.dart';
import 'package:app_deaf/routers.dart';
import 'package:app_deaf/service/profileApi.dart';
import 'package:app_deaf/service/singinApi.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dioApi hide FormData;
import 'package:dio/src/form_data.dart' as dioFormdata;
import 'package:shared_preferences/shared_preferences.dart';

class ProfliePage extends StatefulWidget {
  const ProfliePage({
    Key? key,
    List<ProfileModel>? profileModel,
  }) : super(key: key);

  @override
  State<ProfliePage> createState() => _ProfliePageState();
}

class _ProfliePageState extends State<ProfliePage> {
  final ImagePicker _imagePicker = ImagePicker();
  var imageController = Get.put(ImageController());
  File? file;
  Future<List<ProfileModel>>? futureProfile;

  var index;
  String nameUser = '';
  // กำหนดค่าเริ่มต้น สำหรับ navbar ในการแสดง wiggle หน้าแรก 0 คือ HomePage
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      nameUser = preferences.getString('userName')!;
    });
  }

  Future<Null> chooseImage(ImageSource imageSource) async {
    print('test Image camera');
    try {
      var object = await ImagePicker()
          .pickImage(source: imageSource, maxHeight: 800.0, maxWidth: 800.0);

      //_imagePicker.pickImage(source: imageSource, maxHeight: 800.0, maxWidth: 800.0);
      setState(() {
        file = File( object!.path.toString());
        // file = object.path.toString();
        print('file ${file}');
      });
    } catch (e) {
      print("Error is:,${e}");
    }
  }

  Widget showButtom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Positioned(
          bottom: 0,
          right: 10,
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
                onTap: () async {
                  await chooseImage(ImageSource.gallery);
                },
                child: Icon(
                  Icons.add_photo_alternate,
                  color: Colors.white,
                ),
              )),
        ),
        Container(
          width: 150.0,
          child: file == null
              ? Image.asset('assets/images/logodeaf.jpg')
              : Image.file(file!),
        ),
        Positioned(
          bottom: 0,
          right: 120,
          child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                color: Color.fromARGB(255, 55, 128, 207),
              ),
              child: InkWell(
                onTap: () {
                  chooseImage(ImageSource.camera);
                },
                child: Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.white,
                ),
              )),
        )
      ],
    );
  }

  @override
  Widget showImage() {
    return Container(
      width: 250.0,
      child: file == null ? Image.asset('images/logo.pag') : Image.file(file!),
    );
  }

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
        body: Center(
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: Text(
                "โปรไฟล์ของคุณ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Image

            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // input Widget

                  showButtom(),
                ],
              ),
            ),
            // end Image
            SizedBox(
              height: 35,
            ),
            // Text
            Center(
              child: Text(
                "ชื่อของคุณ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            // การเรียก ข้อมูล จาก snapshot ออกมาแสดง
            Center(
              child: Text('${nameUser.toString()}'),
            ),
            SizedBox(
              height: 70,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF277BC0),
                  shape: const StadiumBorder(),

                  minimumSize: Size(120, 60), // background

                  // foreground
                ),
                onPressed: () {},
                child: Text(
                  'เปลี่ยนรหัสผ่าน',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ))

            // ... other widgets
          ]),
        ));
  }
}

void _handleCilkResetPass({required ProfileModel profileModel}) {
  //
  print(" at _handClickContent == > ${profileModel.toJson()}");

  Get.to(ResetPasswordPage(
    profileModel: profileModel,
  ));
  //  Navigator.pushNamed(context, AppRoute.contents);
  // Navigator.pushNamed(context, AppRoute.navbars);
}
