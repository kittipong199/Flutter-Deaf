import 'dart:convert';
import 'dart:async';
import 'dart:developer';
import 'package:app_deaf/models/Coures.dart';
// import 'package:app_deaf/models/post.dart';
import 'package:app_deaf/utils/constarts.dart';
import 'package:http/http.dart' as http;

import 'package:app_deaf/utils/constarts.dart';

class CouresApi {
  static Future<List<Coures>> futureCouresApi() async {
    final response =
        await http.get(Uri.parse(phpApi +'/getcoures.php'));

    if (response.statusCode == 200) {
      //pares data
      final List result = json.decode(response.body);
      return result.map((e) => Coures.fromJson(e)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
