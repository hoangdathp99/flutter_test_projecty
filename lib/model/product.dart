import 'package:flutter_application_1/model/category.dart';

class ProductType {
  final int id;
  final String title;
  final int price;
  final String description;
  final Category category;
  final List<String> images;

  ProductType({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.images,
  });
  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: Category.fromJson(json['category']),
      images: List<String>.from(json['images']),
    );
  }
}
