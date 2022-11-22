import 'dart:convert';
import 'dart:async';
import 'package:app_deaf/models/post.dart';
import 'package:http/http.dart' as http;

class CouresApi {
  Future<Coures> AllCoures() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/couresname'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Coures.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
    
  }
}
