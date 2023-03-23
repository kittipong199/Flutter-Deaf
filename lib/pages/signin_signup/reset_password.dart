// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert' as convert;

import 'package:app_deaf/models/signinModel.dart';
import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/proflie.dart';
import 'package:app_deaf/utils/normal_dialog.dart';
import 'package:dio/dio.dart' as dioApi hide FormData;
import 'package:dio/src/form_data.dart' as dioFormdata;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_deaf/models/profileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordPage extends StatefulWidget {
  ResetPasswordPage({
    Key? key,
    List<ProfileModel>? profileModel2,
  }) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController resetpassword = TextEditingController();
  String userId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findUser();
  }

  Future<Null> findUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString('id')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // transparent status bar
        systemNavigationBarColor: Colors.black, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // status bar icons' color
        systemNavigationBarIconBrightness:
            Brightness.dark, //navigation bar icons' color
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("เปลี่ยนรหัสผ่าน"),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) => Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        child: Text("Forgot Password?",
                            style: TextStyle(fontSize: 32.0)),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                        child: Text(
                          "ใส่ รหัสผ่านใหม่",
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 13, 13),
                          ),
                        ),
                      ),
                      SizedBox(height: 34.0),
                      Container(
                        width: (constraints.maxWidth > 412)
                            ? ((constraints.maxWidth * 0.5))
                            : (constraints.maxWidth),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            color: Color.fromARGB(255, 230, 198, 198),
                            borderRadius: BorderRadius.circular(6.0)),
                        child: TextFormField(
                          controller: resetpassword,
                          validator: (String? input) {
                            if (input == null || input.isEmpty) {
                              return 'กรุณาใส่ รหัสผ่านด้วย!';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'รหัสใหม่',
                          ),
                          obscureText: true,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                (constraints.maxWidth > 412)
                                    ? ((constraints.maxWidth * 0.5))
                                    : (constraints.maxWidth),
                                50),
                          ),
                          child: Text("Reset Password"),
                          onPressed: () {
                            // place sign in function here
                            getProfile();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Spacer(),
                      SizedBox(height: 16.0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> getProfile() async {
    var dio = dioApi.Dio();

    var formData = resetpassword.text;

    var urlApi =
        "http://sit.thonburi-u.ac.th/phpApi/resetPassword.php?isAdd=true&id=${userId.toString()}&passwords=${formData.toString()}";

    resetpassword.text = "";

    print(urlApi);
    //content.dart response = await dio.get(urlApi);
    var response = await dio.get(urlApi);
    var bodys = convert.json.decode(response.data.toString());
    print("ค่าจากการเปลี่ยนรหัสผ่าน ==== ${bodys.toString()}");

    // var profile = bodys![2].map((e) => ProfileModel.fromJson(e)).toList();

    // for (var map in bodys) {
    //   LoginModel loginModel = LoginModel.fromJson(map);
    //   if (formData == loginModel.passwords) {
    //     normalDialog(context, 'เปลี่ยนรหัสผ่าน เรียบร้อย');
    //     Get.back();
    //   } else {}
    // }
  }
}
