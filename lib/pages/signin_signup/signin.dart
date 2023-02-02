// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert' as convert;

import 'dart:developer';
import 'dart:math';

// import 'package:app_deaf/service/couresApi.dart';
import 'package:app_deaf/models/signinModel.dart';
import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/proflie.dart';
import 'package:app_deaf/routers.dart';
import 'package:app_deaf/service/signUpApi.dart';
import 'package:app_deaf/service/singinApi.dart';
import 'package:app_deaf/themes/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart' as dioApi hide FormData;
import 'package:dio/src/form_data.dart' as dioFormdata;

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
  late TextEditingController user_name = TextEditingController();
  late TextEditingController passwords = TextEditingController();

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

  void _login() async {
    var dio = dioApi.Dio();

    //var urls ="http://10.0.2.2/deafapp/phpapi/getUserWhereUser.php?isAdd=true&user_name=${user_name.text}&passwords=${passwords.text}";

    var urls = "http://10.0.2.2/deafapp/phpapi/loginuser.php";
    print(urls);
    dioFormdata.FormData formdata = dioFormdata.FormData.fromMap({
      'user_name': user_name.text,
      'passwords': passwords.text,
    });
    //var response = await SigninApi.logintoApp(formdata, urls);
    var response = await dio.post(urls, data: formdata);
    // response.obs.firstRebuild คือ การแปลง ข้อมูล ให้อยู่ในรูปแบบ ของ bool ทำให้
    // user_name.text = "";
    // passwords.text = "";
    var bodys = convert.json.decode(response.data.toString());

    List<dynamic> result = bodys[2];
    // add result to model name LoginModel
    List<LoginModel> loginUser =
        result.map((e) => LoginModel.fromJson(e)).toList();

    print(bodys[2]);

    print(loginUser.toString());

    for (var model in loginUser) {
      print("id: ${model.id}");
      print("user_name: ${model.userName}");
      print("passwords: ${model.passwords}");
      print("images: ${model.images}");

  
    }
    // void nexttoHone({required LoginModel loginModel}) {

    // }

    if (bodys[0] == "Success") {
      print("ok pass");

      //Get.to(NavbarPage(id: id));
      for (var model in loginUser) {
          if(model.id != null){
            Get.to(NavbarPage(id: model.id.toString()));
        }
        }
     
    } else {
      print("ยังเขียนไม่ถูกหาวิธ๊ใหม่");
    }
  }

  // void nexttoHone({required LoginModel loginModel}) {
  //   Get.to(NavbarPage(id: id));
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

                              _login();

                              // _toHome();
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
}
