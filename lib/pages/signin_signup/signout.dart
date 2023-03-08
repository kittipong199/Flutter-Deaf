import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/signin_signup/signin.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Null> signOutPage(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();

  MaterialPageRoute route = MaterialPageRoute(
    builder: (context) => SignInPage(),
  );

  Navigator.pushAndRemoveUntil(context, route, (route) => false);
}
