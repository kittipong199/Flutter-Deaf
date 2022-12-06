
import 'package:app_deaf/pages/coures.dart';
import 'package:app_deaf/pages/history.dart';
import 'package:app_deaf/pages/home/home.dart';
import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/proflie.dart';
import 'package:app_deaf/pages/signin_signup/signin.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routers = <String, WidgetBuilder>{

  "/":(BuildContext context) => NavbarPage(),
  "/home":(BuildContext context) => HomaPage(),
  "/coures":(BuildContext context) => CouresPage(),
  // "/":(BuildContext context) => ContentPage(),
  "/history":(BuildContext context) => HistoryPage(),
  "/profile":(BuildContext context) => ProfliePage(),

};
