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
}
