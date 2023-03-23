// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert' as convert;

import 'dart:developer';
import 'dart:math';

// import 'package:app_deaf/service/couresApi.dart';
import 'package:app_deaf/models/signinModel.dart';
import 'package:app_deaf/pages/menu/navbar.dart';

import 'package:app_deaf/routers.dart';

import 'package:app_deaf/service/singinApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:app_deaf/utils/normal_dialog.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dio/dio.dart' as dioapi;

import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  // final LoginModel loginModel;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // String user_name ,passwords;
   TextEditingController user_name = TextEditingController();
   TextEditingController passwords = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  //Future<List<LoginModel>>? loginToProfile;
  bool? haveData;
  Future<List<LoginModel>>? futureUser;
  // loading
  bool _isLoading = false;
  var loginModel = <LoginModel>[];

  get id => null;
  @override
  void initState() {
    super.initState();

    // futureSignin = SigninApi.futureSigninApi();
  }

  
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
                                    fontSize: 20.0, color: Color.fromARGB(255, 255, 255, 255)),
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
                          normalDialog(context, 'ใส่ชื่อผู้ใช้งาน');
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
                            normalDialog(context, 'ใส่รหัสผ่าน');
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
                              checkUseLogin();

                              // _toHome();
                            }, // เมื่อกดปุ่ม ให้เรียกใช้ postRegister

                            child: const Text(
                              "ล็อกอิน",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20.0, 
                                  fontWeight: FontWeight.bold),
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

  Future<Null> checkUseLogin() async {
    var userName = user_name.text;
    var pass = passwords.text;
    var dio = dioapi.Dio();
    var url =
        'http://sit.thonburi-u.ac.th/phpApi/checkUser.php?isAdd=true&user_name=${userName}';
    try {
      var response = await dio.get(url);
      var bodys = convert.json.decode(response.data.toString());
      print('resCheckUser == ${bodys}');
      // if (bodys == null) {
      // } else {
      //   normalDialog(context, 'User นี่ ${userName.toString()} มีคนใช้แล้ว');
      // } 
      for (var map in bodys) {
        LoginModel loginModel = LoginModel.fromJson(map);
        if (pass == loginModel.passwords) {
          datalogLoginUser(NavbarPage(), loginModel);
        } else {
          normalDialog(context, 'รหัสผ่านไม่ถูกต้อง');
        }
      }
    } catch (e) {}
  }

  Future<Null> datalogLoginUser(Widget myWidget, LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', loginModel.id.toString());
    preferences.setString('userName', loginModel.userName.toString());
    preferences.setString('password', loginModel.passwords.toString());

    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
