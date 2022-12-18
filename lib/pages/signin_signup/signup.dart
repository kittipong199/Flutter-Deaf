import 'dart:convert';
import 'dart:developer';

// import 'package:app_deaf/service/couresApi.dart';
import 'package:app_deaf/routers.dart';
import 'package:app_deaf/service/signUpApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // String user_name ,passwords;
  late TextEditingController user_name = TextEditingController();
  late TextEditingController passwords = TextEditingController();

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
                                  fontSize: 20.0, color: Colors.black),
                            ))
                      ],
                    ),
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
                            bool pass = formkey.currentState!.validate();

                            if (pass) {
                              postRegister();
                             _toSignin();
                            }
                          }, // เมื่อกดปุ่ม ให้เรียกใช้ postRegister

                          child: const Text(
                            "สมัครสมาชิก",
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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

  void postRegister() async {
    var formData = {
      'user_name': user_name.text,
      'passwords': passwords.text,
    };

    user_name.text = "";

    passwords.text = "";
    //Call API
    var response = await SignUpApi().postData(formData, '/registoruser.php');
    print(formData);
    print(response.data.toString());
    var body = json.decode(response.body);
    print(body);
    // myFocusNode.requestFocus();
  }
}
// Future RegisterUser() async {
//   // url to api PHP
//   var APIURL = "http://10.0.2.2/phpApi/registoruser.php";

//   var user_name;
//   var passwords;
//   Map mapeddate = {'user_name': user_name.text, 'passwords': passwords.text};

//   // send data useing from post to my api php
//   http.Response reponse = await http.post(APIURL,body:mapeddate);

//   var data = jsonDecode(reponse.body);

//   print("Data: ${data}");
// }