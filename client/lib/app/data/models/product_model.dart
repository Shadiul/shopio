import '../../utils/log_colored.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final int discount;
  final String? categoryId;
  final String unit;
  int stockQuantity;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    this.categoryId,
    required this.unit,
    required this.stockQuantity,
    this.images = const [],
  });

  double get priceAfterDiscount => price - ((price * discount) / 100);
  bool get isStockAvailable => stockQuantity > 1;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: _toPriceDouble(json['price']),
      categoryId: json['category_id'],
      unit: json['unit'],
      discount: json['discount'] ?? 0.0,
      stockQuantity: json['stock_quantity'] ?? 0,
      images: _mapImages(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['category'] = categoryId;
    data['unit'] = unit;
    data['discount'] = discount;
    data['stock_quantity'] = stockQuantity;

    return data;
  }

  static double _toPriceDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        logColored(e.toString(), color: LogColor.red);
        return 0.0;
      }
    } else {
      return 0.0;
    }
  }

  static List<String> _mapImages(List<dynamic>? data) {
    if (data is List) {
      return List<String>.from(data.map((e) => e)).toList();
    } else {
      return [];
    }
  }
}
