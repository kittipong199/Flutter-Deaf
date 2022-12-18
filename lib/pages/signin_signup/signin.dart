import 'dart:convert';
import 'dart:developer';

// import 'package:app_deaf/service/couresApi.dart';
import 'package:app_deaf/models/signinModel.dart';
import 'package:app_deaf/routers.dart';
import 'package:app_deaf/service/signUpApi.dart';
import 'package:app_deaf/service/singinApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // String user_name ,passwords;
  late TextEditingController user_name = TextEditingController();
  late TextEditingController passwords = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  
  Future<List<LoginModel>>? futureSignin;
  @override
  void initState() {
    super.initState();
    // futureSignin = SigninApi.futureSigninApi();
    
  }

  // Future<void> inserrecord() async {
  //   // String jsondata =
  //   //     '{"user_name":"${user_name.text}", "passwors":"${passwords.text}"}';
  //   if (user_name.text != "" || passwords.text != "") {
  //     try {
  //       var url =
  //           Uri.http("10.0.2.2", '/phpapi/registoruser.php', {'q': '{http}'});
  //       var res = await http.post(url, body: {
  //         "user_name": user_name.text.toString(),
  //         "passwords": passwords.text.toString()
  //       });

  //       var data = jsonDecode(res.body);
  //       if (data["success"] == "ture") {
  //         print("Record Inserted");
  //         user_name.text = "";
  //         passwords.text = "";
  //       } else {
  //         print("some isssue");
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   } else {
  //     print("Please fill all file");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xFFFFD218),

      //body
      body: Container(
        child: Center(
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
                              onPressed: () {},
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

                    const SizedBox(
                      height: 30,
                    ),

                    // user_name
                    TextFormField(
                      controller: user_name,
                      validator: (String? input) {
                        if (input == null || input.isEmpty) {
                          return 'กรุณาใส่ ชื่อผู้ใช้งาน!';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
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
                            return 'กรุณาใส่ รหัสผ่าน!';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
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
 
                              }
                            }, // เมื่อกดปุ่ม ให้เรียกใช้ postRegister

                            child: const Text(
                              "ล็อกอิน",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    ));
  }

  void _toSignUp() {
    Navigator.pushNamed(context, AppRoute.signup);
    // Navigator.pushNamed(context, AppRoute.navbars);
  }

  void _toHome() {
    Navigator.pushNamed(context, AppRoute.navbars);
    // Navigator.pushNamed(context, AppRoute.navbars);
  }

  //  function send data to service api
  void postRegister() async {
    // เก็บ ข้อมูลจาก TextFormfield เป็น array
    var formData = {
      'user_name': user_name.text,
      'passwords': passwords.text,
    };

    user_name.text = "";

    passwords.text = "";
    //Call API
    var response = await SigninApi.futureSigninApi(formData);
         // sent data and link api to file Service SignUpApi
    print(formData);
    // print(response.data.toString());
    // var body = json.decode(response.body);
    // print(body);
    // myFocusNode.requestFocus();
  }
}
