import 'dart:convert';

import 'dart:async';
import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/models/signinModel.dart';

import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class SigninApi {
  _setHeaders() =>
      {'Content-type': 'application/json', 'Accept': 'application/json'};
  // register user

  //   getData(data, apiURL) async {

  //   var fullURL = phpApi + apiURL;
  //   return await http.get(Uri.parse(fullURL),

  //     // body: jsonEncode(data),
  //     // headers: _setHeaders()
  //   );

  // }

  static Future<List<LoginModel>> futureSigninApi(data) async {
    final response = await http.get(Uri.parse(phpApi + '/loginuser.php'));

    // if (response.statusCode == 200) {
    //   late bool datas = false;
    //   return datas = true;
    // }
    if (response.statusCode == 200) {
      //pares data

      final List result = json.decode(response.body);

      return result.map((e) => LoginModel.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
