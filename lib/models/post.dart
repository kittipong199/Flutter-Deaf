import 'dart:convert';

// List<Post> postFromJson(String str) => List<Post>.from(json.decode(source));

// String postToJson(List<Post> data) => json.encode(List<dynamic>.from(elements));

class Coures {
  final int id;
  final String couresname;

  const Coures({required this.id, required this.couresname});

  factory Coures.fromJson(Map<String, dynamic> json) {
    return Coures(id: json['id'],
     couresname: json['couresname']);
  }
}
