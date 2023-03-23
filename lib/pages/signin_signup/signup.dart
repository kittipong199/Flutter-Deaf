import 'dart:convert' as convert;
import 'dart:developer';

import 'package:app_deaf/routers.dart';
import 'package:app_deaf/service/signUpApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:app_deaf/utils/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart'  as dioapi;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // String user_name ,passwords;
   TextEditingController user_name = TextEditingController();
   TextEditingController passwords = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFD218),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: formkey,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: _toSignin,
                              child: Text(
                                "Sign in ",
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.black),
                              )),
                          TextButton(
                              onPressed: _toSignUp,
                              child: Text(
                                "Sign UP",
                                style: TextStyle(
                                    fontSize: 20.0, color: Color.fromARGB(255, 248, 247, 247)),
                              ))
                        ],
                      ),
                    ),
                        const SizedBox(
                      height: 30,
                    ),

                    // username
                    TextFormField(
                      controller: user_name,
                      validator: (String? input) {
                        if (input == null || input.isEmpty) {
                          return 'กรุณาใส่ ชื่อผู้ใช้งาน!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
                        ),
                        hintText: 'Username',
                        label: Text("UserName"),
                        border: OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    /// Password
                    Container(
                      child: TextFormField(
                        controller: passwords,
                        validator: (String? input) {
                          if (input == null || input.isEmpty) {
                            return 'กรุณาใส่ รหัสผ่านด้วย!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.password,
                          ),
                          hintText: 'Password',
                          label: Text("Password"),
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),

                    /// Buttom
                    ///
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(100, 40),
                              backgroundColor: Color.fromARGB(255, 39, 123,
                                  192), //fromARGB(255, 39, 123, 192)
                            ),
                            onPressed: () {
                             
                              if (user_name == null || passwords == null) {
                                normalDialog(context, 'ใส่ชื่อ และ รหัสให้ครบ');
                              } else {
                                checkUser();
                              }
                            }, // เมื่อกดปุ่ม ให้เรียกใช้ postRegister

                            child: const Text(
                              "สมัครสมาชิก",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 10, 10, 10),
                                  fontSize: 20.0, 
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    ));
  }

  void _toSignUp() {
    Navigator.pushNamed(context, AppRoute.signup);
    // Navigator.pushNamed(context, AppRoute.navbars);
  }

  void _toSignin() {
    Navigator.pushNamed(context, AppRoute.signin);
    // Navigator.pushNamed(context, AppRoute.navbars);
  }

  Future<Null> checkUser() async {
    var userName = user_name.text;
    var dio = dioapi.Dio();
    var url =
        'http://sit.thonburi-u.ac.th/phpApi/checkUser.php?isAdd=true&user_name=${userName}';
    try {
     var response = await dio.get(url);
      var bodys = convert.json.decode(response.data.toString());
      print('resCheckUser == ${bodys}');
      if (bodys == null) {
          postRegister();
      } else {
        normalDialog(context, 'User นี่ ${userName.toString()} มีคนใช้แล้ว');
      }
    } catch (e) {}
  }

  Future<Null> postRegister() async {
     var userName = user_name.text;
     var pass = passwords.text;
     var dio = dioapi.Dio();
    var url =
        'http://sit.thonburi-u.ac.th/phpApi/signup.php?isAdd=true&user_name=${userName}&passwords=${pass}';

    try {
      var response = await dio.get(url);
       var bodys = convert.json.decode(response.data.toString());
      print('res == ${bodys.toString()}');

      if (bodys.toString() == 'true') {
        Get.back();
      } else {
        // normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองใหม่');
      }
    } catch (e) {}
  }
}
  // void postRegister() async {
  //   var formData = {
  //     'user_name': user_name.text,
  //     'passwords': passwords.text,
  //   };

  //   user_name.text = "";

  //   passwords.text = "";
  //   //Call API
  //   var response = await SignUpApi().postData(formData, '/registoruser.php');
  //   print(formData);
  //   print(response.data.toString());
  //   var body = json.decode(response.body);
  //   print(body);
  //   // myFocusNode.requestFocus();
  // }

