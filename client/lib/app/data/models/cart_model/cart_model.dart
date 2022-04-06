import 'package:get/get.dart';

import '../product_model.dart';
import 'cart_item_model.dart';

class CartModel {
  final RxList<CartItemModel> items = RxList<CartItemModel>();

  final RxDouble _totalPrice = RxDouble(0.0);
  double get totalPrice => _totalPrice.value;

  int itemCount(ProductModel product) {
    int index = items.indexWhere((element) => element.product.id == product.id);
    return items[index].quantity;
  }

  void calculateTotal() {
    double tempTotalPrice = 0.0;
    for (var item in items) {
      tempTotalPrice = tempTotalPrice + item.totalPrice;
    }
    _totalPrice.value = tempTotalPrice;
  }

  void addItem(ProductModel product) {
    if (product.stockQuantity < 1) {
      return;
    }
    items.firstWhere(
      (element) => element.product.id == product.id,
      orElse: () {
        items.insert(0, CartItemModel(product: product));
        return items[0];
      },
    ).increase();

    calculateTotal();
  }

  void increaseItem(ProductModel product) {
    items.firstWhere(
      (element) => element.product.id == product.id,
      orElse: () {
        items.insert(0, CartItemModel(product: product));
        return items[0];
      },
    ).increase();

    calculateTotal();
  }

  void removeItem(ProductModel product) {
    int index = items.indexWhere((element) => element.product.id == product.id);
    items[index].remove();
    items.removeAt(index);
    calculateTotal();
  }

  void removeAllItem() {
    items.clear();
    calculateTotal();
  }

  void decreaseItem(ProductModel product) {
    int index = items.indexWhere((element) => element.product.id == product.id);

    if (items[index].quantity > 1) {
      items[index].decrease();
    } else {
      items[index].remove();
      items.removeAt(index);
    }

    calculateTotal();
  }

  bool doesExists(ProductModel product) {
    for (var element in items) {
      if (element.product.id == product.id) return true;
    }
    return false;
  }
}
