import 'package:app_deaf/pages/content.dart';
import 'package:app_deaf/pages/coures.dart';
import 'package:app_deaf/pages/history.dart';
import 'package:app_deaf/pages/home/home.dart';
import 'package:app_deaf/pages/menu/navbar.dart';
import 'package:app_deaf/pages/proflie.dart';
import 'package:app_deaf/pages/signin_signup/reset_password.dart';
import 'package:app_deaf/pages/signin_signup/signin.dart';
import 'package:app_deaf/pages/signin_signup/signup.dart';
import 'package:app_deaf/pages/video_content.dart';
import 'package:flutter/material.dart';

// final Map<String, WidgetBuilder> routers = <String, WidgetBuilder>{

//   "/":(BuildContext context) => NavbarPage(),
//   "/home":(BuildContext context) => HomaPage(),
//   "/coures":(BuildContext context) => CouresPage(),
//   // "/":(BuildContext context) => ContentPage(),
//   "/history":(BuildContext context) => HistoryPage(),
//   "/profile":(BuildContext context) => ProfliePage(),

// };

class AppRoute {
  static const navbars = 'navbar';
  static const home = 'home';
  static const coure = 'coures';
  //static const contents = 'contents';
  static const content_video = 'content_video';
 static const signin = 'signin';
  static const signup = 'signup';

  static const reset_password = 'reset_password';
  static get all => <String, WidgetBuilder>{
        navbars: (context) => const NavbarPage(id: 'id',),
        home: (context) => const HomaPage(),
        coure:(context) => const CouresPage(),
        //contents:(context) => const ContentPage(),
        content_video:(context) => const VideoContentPage(),
        signin:(context) => const SignInPage(),
        signup:(context) => const SignUpPage(),
         //reset_password:(context) => const ResetPasswordPage(profileModel: 'pro',),

      };
}
