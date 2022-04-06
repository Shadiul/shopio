import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/models.dart';
import '../../data/services/services.dart';

class PaymentController extends GetxController {
  final CartService _cartService = Get.find<CartService>();

  CartModel get cart => _cartService.cart;

  Future<void> onTapPaymentMethod(String method) async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: 'Payment Complete!',
        middleText: 'Payment of ${cart.totalPrice}\$ received by $method',
        actions: [
          ElevatedButton(
            onPressed: () {
              cart.removeAllItem();
              Get.back();
              Get.back();
            },
            child: const Text('OK'),
          ),
        ]);
  }
}
