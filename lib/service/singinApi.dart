import 'dart:convert';

import 'dart:async';
import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/models/signinModel.dart';

import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class SigninApi {
 

  static Future<List<LoginModel>> futureSigninApi() async {

    String ursl = 'https://www.androidthai.in.th/fluttertraining/getUserWhereUser.php?isAdd=true&user_name=1&passwords=2';
    final response = await http.get(Uri.parse(ursl));

  
    if (response.statusCode == 200) {
      //pares data

      final List result = json.decode(response.body);

      return result.map((e) => LoginModel.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
