// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert' as convert;

import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/proflie.dart';
import 'package:dio/dio.dart' as dioApi hide FormData;
import 'package:dio/src/form_data.dart' as dioFormdata;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_deaf/models/profileModel.dart';

class ResetPasswordPage extends StatefulWidget {
  final ProfileModel profileModel;
  ResetPasswordPage({
    Key? key,
    required this.profileModel,
    List<ProfileModel>? profileModel2,
  }) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late TextEditingController resetpassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        child: Text("ใส่ รหัสผ่านใหม่"),
                      ),
                      SizedBox(height: 64.0),
                      Container(
                        width: (constraints.maxWidth > 412)
                            ? ((constraints.maxWidth * 0.5))
                            : (constraints.maxWidth),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade200),
                            color: Colors.white,
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

  Future<List<ProfileModel>>? getProfile() async {
    var dio = dioApi.Dio();
    //var data = widget.id.toString();
    // var getid = data;
    //print(data.runtimeType);
    var formData = resetpassword.text;

    var urlApi =
        "http://sit.thonburi-u.ac.th/phpApi/resetPassword.php?isAdd=true&id=${widget.profileModel.id}&passwords=${formData.toString()}";

    resetpassword.text = "";
    
    print(urlApi);
    //content.dart response = await dio.get(urlApi);
    var response = await dio.get(urlApi);
    var bodys = convert.json.decode(response.data.toString());

    //List<dynamic> result = bodys[2];
    //print(result.runtimeType);
    // add result to model name LoginModel
    var profile = bodys![2].map((e) => ProfileModel.fromJson(e)).toList();

    print(bodys);

    print(bodys[2]);

    print(profile.toString());

    for (var model in profile) {
      print("id: ${model.id}");
      print("user_name: ${model.userName}");
      print("passwords: ${model.passwords}");
      print("images: ${model.images}");
    }

    return profile;
  }
}
