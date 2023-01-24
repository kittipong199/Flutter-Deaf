import 'dart:convert';

import 'dart:async';
import 'package:app_deaf/models/ContentModel.dart';
import 'package:app_deaf/models/signinModel.dart';

import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioApi hide FormData;

class SigninApi {
    logintoApp(data, urllogin) async {
      var fulldata = phpApi + urllogin;

      var dio = dioApi.Dio();

      return await dio.post(fulldata);
  }

  }

// อันเก่า
  // static Future<List<LoginModel>> futureSigninApi() async {

  var urls = "http://10.0.2.2/deafapp/phpapi/loginuser.php";
  // String ursl = 'http://10.0.2.2/deafapp/phpapi/getUserWhereUser.php?isAdd=true&user_name=${loginModel.userName}&passwords=${loginModel.passwords}';

  //print(urls);

  //final response = await http.get(Uri.parse(ursl));

  //

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

//}
