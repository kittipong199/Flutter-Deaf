import 'dart:io';

import 'package:app_deaf/pages/coures.dart';
import 'package:app_deaf/routers.dart';

import 'package:app_deaf/utils/app_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({    Key? key,
   
  }) : super(key: key);
  @override
  State<HomaPage> createState() => _HomaPageState();
}

Future<Null> logOut() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
  exit(0);
}

class _HomaPageState extends State<HomaPage> {
  int navindex = 0;
  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print(" at Home startlearn  ==> ${appController.startLearn} ");
          return Scaffold(
            // backgroundColor: Color(0xFFFFB200),
            appBar: AppBar(
              leading: appController.startLearn.value
                  ? IconButton(
                      onPressed: () {
                        appController.startLearn.value = false;
                      },
                      icon: const Icon(Icons.arrow_back))
                  : null,
              backgroundColor: Color(0xFFFFB200),
              title: Text(
                appController.startLearn.value ? 'หัวข้อเรียน' : "หน้าแรก",
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                IconButton(onPressed: () => logOut(),tooltip: 'ออกจากระบบ' ,icon: Icon(Icons.exit_to_app))
              ],
            ),

            body: appController.startLearn.value ? CouresPage() : CurrendHome(),
          );
        });
  }

  void _handleCilkCoure() {
    Navigator.pushNamed(context, AppRoute.coure);
    // Navigator.pushNamed(context, AppRoute.navbars);
  }
}

class CurrendHome extends StatelessWidget {
  const CurrendHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX(
        init: AppController(),
        builder: (AppController appController) {
          print("At CurrendHome ==> ${appController.startLearn}");
          return Center(
            child: Container(
              // btn เริ่มเรียน
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // image logo

                  CircleAvatar(
                    radius: 80,
                    foregroundImage: AssetImage('assets/images/logodeaf.jpg'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //  btn เริ่มเรียน
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF277BC0),
                        shape: const StadiumBorder(),

                        minimumSize: Size(120, 50), // background

                        // foreground
                      ),
                      onPressed: () {
                        appController.startLearn.value = true;
                      },
                      child: Text(
                        'เริ่มเรียน',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
