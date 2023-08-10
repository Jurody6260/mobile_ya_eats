import 'package:http/http.dart' as http;
import 'package:mobile_ya_eats/constants.dart';
import 'dart:async';
import 'dart:convert';

class Product {
  final String image, title, description, color;
  final int price, size, id;

  Product({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.price,
    required this.size,
    required this.color,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.parse(json['id']),
      title: json['title'],
      image: json['image'],
      description: json['description'],
      price: int.parse(json['price']),
      size: int.parse(json['size']),
      color: json['color'],
    );
  }
}

Future<List<Product>> fetchProducts() async {
  final response = await http.get(Uri.parse("${apiOriginName}products"));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final jsonResponse = jsonDecode(response.body);
    return jsonResponse
        .map((item) => Product.fromJson(item))
        .toList()
        .cast<Product>();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load PRODUCTS');
  }
}
