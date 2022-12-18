import 'dart:convert';


import 'dart:async';
import 'package:app_deaf/models/ContentModel.dart';


import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;

class SignUpApi {

  _setHeaders() =>{
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };
    // register user 

    postData(data, apiURL) async {

       var fullURL = phpApi + apiURL;
    return await http.post(Uri.parse(fullURL),
     
      body: jsonEncode(data),
      headers: _setHeaders()
    );

  }
    

   
  }
