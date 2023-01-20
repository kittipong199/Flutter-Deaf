import 'dart:convert';

import 'dart:async';
import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/models/signinModel.dart';

import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class SigninApi {
 
// อันเก่า
  static Future<List<LoginModel>> futureSigninApi({required LoginModel loginModel}) async {

    String ursl = 'http://10.0.2.2/deafapp/phpapi/getUserWhereUser.php?isAdd=true&user_name=${loginModel.userName}&passwords=${loginModel.passwords}';
    final response = await http.get(Uri.parse(ursl));

  
    if (response.statusCode == 200) {
      //pares data

      final List result = json.decode(response.body);

      return result.map((e) => LoginModel.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
  // อันใหม่
  // _setHeaders() =>{
  //   'Content-type': 'application/json',
  //   'Accept': 'application/json'
  // };
  //   // register user 

  //   postLogin(apiURL) async {

  //      var fullURL = phpApi + apiURL;
  //   return await http.post(Uri.parse(fullURL),
     
      
  //     headers: _setHeaders()
  //   );

  // }

}
