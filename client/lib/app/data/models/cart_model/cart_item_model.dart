import 'package:get/get.dart';

import '../product_model.dart';

class CartItemModel {
  final ProductModel product;
  CartItemModel({required this.product});

  final RxInt _quantity = RxInt(0);
  int get quantity => _quantity.value;

  final RxDouble _totalPrice = RxDouble(0.0);
  double get totalPrice => _totalPrice.value;

  void increase() {
    if (product.stockQuantity > 0) {
      _quantity.value++;
      product.stockQuantity--;

      _totalPrice.value = product.priceAfterDiscount * quantity;
    }
  }

  void decrease() {
    if (quantity > 0) {
      _quantity.value--;
      product.stockQuantity++;

      _totalPrice.value = product.priceAfterDiscount * quantity;
    }
  }

  void remove() {
    product.stockQuantity += quantity;
  }
}
