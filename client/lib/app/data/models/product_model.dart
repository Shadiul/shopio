import 'category_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int discount;
  final CategoryModel category;
  final String unit;
  int stockQuantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.category,
    required this.unit,
    required this.stockQuantity,
  });

  double get priceAfterDiscount => (price * discount) / 100;
  bool get isStockAvailable => stockQuantity > 1;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      unit: json['unit'],
      discount: json['discount'] ?? 0.0,
      stockQuantity: json['stock_quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = category;
    data['unit'] = unit;
    data['discount'] = discount;
    data['stock_quantity'] = stockQuantity;

    return data;
  }
}
