import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final Timestamp timestamp;
  final String name;
  final String icon;
  int productsCount;

  CategoryModel({
    required this.id,
    required this.timestamp,
    required this.name,
    required this.icon,
    this.productsCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      timestamp: json['timestamp'],
      name: json['name'] ?? 'Unknown Category',
      icon: json['icon'],
      productsCount: json['products_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['timestamp'] = timestamp;
    data['name'] = name;
    data['icon'] = icon;
    data['products_count'] = productsCount;

    return data;
  }
}
