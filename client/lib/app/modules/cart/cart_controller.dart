import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/models.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class CartController extends GetxController {
  final CartService _cartService = Get.find<CartService>();

  CartModel get cart => _cartService.cart;

  Future<void> onTapCartItem(ProductModel product) async {
    await Get.toNamed(
      Routes.PRODUCT_DETAILS,
      parameters: {'id': product.id},
      arguments: product,
    );
  }

  Future<void> onTapPlaceOrder() async {
    if (cart.items.isNotEmpty) {
      await Get.toNamed(
        Routes.PAYMENT,
      );

      return;
    }

    if (cart.items.isEmpty) {
      if (Get.isSnackbarOpen != null && !Get.isSnackbarOpen!) {
        Get.showSnackbar(GetBar(
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.error),
          message: 'No items in your cart!',
          duration: const Duration(seconds: 2),
          isDismissible: true,
        ));
      }
    }
  }
}
