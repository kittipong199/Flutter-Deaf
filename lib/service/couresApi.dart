import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:app_deaf/models/Coures.dart';
import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;

class CouresApi {
  static Future<List<Coures>> futureCouresApi() async {

   
    String ursl = 'https://www.androidthai.in.th/fluttertraining/getAllCoursArt.php';
       
    final response = await http.get(Uri.parse(ursl));

    if (response.statusCode == 200) {
      // parse data
      final List result = json.decode(response.body);
      return result.map((e) => Coures.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
