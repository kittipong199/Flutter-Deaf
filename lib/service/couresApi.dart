import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:app_deaf/models/Coures.dart';
// import 'package:app_deaf/models/post.dart';
import 'package:http/http.dart' as http;

import 'package:app_deaf/utils/constarts.dart';

class CouresApi {
  String urlApi = "http:10.0.2.2:8000/api";

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accect': 'application/json'
  };

  Future<List<Coures>?> futureCoures() async {
   
      final response =  await http.get(Uri.parse('http:10.0.2.2:8000/api/couresname'));
         
      //log('status code = ${response.statusCode}');
      // log(response.body);
      if (response.statusCode == 200) {
        //pares data
        final List result = json.decode(response.body);
        return result.map((e) => new Coures.fromJson(e)).toList();
        // final jsonString = jsonEncode(json);
        // log(jsonString);
        // final coures = couresFromJson(jsonString);
        // //log('todo = ${coures}');
        // return coures;
      } else {
        //return not connect api
        // return null;
        throw Exception('Unexpected error occured!');
      }
   

// // login
//   postData(data, apiUrl) async {
//     var fullURL = baseURLAPI + apiUrl;

//     return await http.post(
//       fullURL,
//       body.jsonEncode(data),
//       headers: _setHeaders()
//     );
  }

// Future<Coures> AllCoures() async {
//   final response =
//       await http.get(Uri.parse('http://localhost:8000/api/couresname'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Coures.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }

// }
}
