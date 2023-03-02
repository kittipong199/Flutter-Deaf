import 'dart:developer';
import 'dart:io';
import 'dart:convert' as convert;
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

import 'package:http/http.dart' as http;

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

  final file = File;
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
  // Future<List<ProfileModel>> getProfile() async {
  //   var dio = dioApi.Dio();
  //   //var data = widget.id.toString();
  //   // var getid = data;
  //   //print(data.runtimeType);
  //   // var urlApi =
  //   //     "http://10.0.2.2/deafapp/phpapi/getProfileWhereUser.php?id=${widget.id}";
  //   // print(urlApi);
  //   //content.dart response = await dio.get(urlApi);
  //   // var response = await dio.get(urlApi);
  //   // var bodys = convert.json.decode(response.data.toString());
  //   // print(bodys);
  //   // List<dynamic> result = bodys[2];
  //   // print(result.runtimeType);
  //   // // add result to model name LoginModel
  //   // List<ProfileModel> profile =
  //   //     result.map((e) => ProfileModel.fromJson(e)).toList();

  //   // print(bodys[2]);

  //   // print(profile.toString());

  //   // for (var model in profile) {
  //   //   print("id: ${model.id}");
  //   //   print("user_name: ${model.userName}");
  //   //   print("passwords: ${model.passwords}");
  //   //   print("images: ${model.images}");
  //   // }
  //   // return profile;
  // }

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
            Center(
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
                      // image: DecorationImage(
                      //     fit: BoxFit.cover,
                      //     image: file == null ? AssetImage('assets/images/logo.jpg') : Image.file(file)

                      //     )
                    ),
                  ),
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
                          onTap: () => chooseImage(ImageSource.camera),
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
              ),
            ),
            // การเรียก ข้อมูล จาก snapshot ออกมาแสดง
            Center(
              child: Text('======${nameUser.toString()}========'),
            ),
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

Future<Null> chooseImage(ImageSource imageSource) async {
  try {
    var object = await ImagePicker.platform
        .pickImage(source: imageSource, maxHeight: 800.0, maxWidth: 800.0);

    // setState(() {
    //   var file = object;
    // });
  } catch (e) {
    print("Error is:,${e}");
  }
}


