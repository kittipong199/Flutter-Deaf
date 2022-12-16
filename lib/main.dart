import 'package:app_deaf/pages/signin_signup/signin.dart';
import 'package:app_deaf/routers.dart';
import 'package:app_deaf/pages/home/home.dart';

import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/coures.dart';
import 'package:app_deaf/pages/test%20_core.dart';

import 'package:app_deaf/pages/video_content.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

final navigatorState = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRoute.all,
      home: SignInPage(),
      navigatorKey: navigatorState,
    );
  }
}
