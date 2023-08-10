import 'package:http/http.dart' as http;
import 'package:mobile_ya_eats/constants.dart';
import 'dart:async';
import 'dart:convert';

class Category {
  final int id;
  final String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: int.parse(json['id']),
      name: json["name"],
    );
  }
}

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse("${apiOriginName}categories"));
  if (response.statusCode == 200) {
    return jsonDecode(response.body)
        .map((item) => Category.fromJson(item))
        .toList()
        .cast<Category>();
  } else {
    throw Exception('Failed to load CATEGORIES');
  }

}
