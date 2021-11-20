import 'package:get/get.dart';

import '../../data/models/models.dart';
import '../../data/services/services.dart';

class ProductDetailsController extends GetxController {
  ProductModel get product => Get.arguments as ProductModel;

  final CartService _cartService = Get.find<CartService>();
  CartModel get cart => _cartService.cart;
}
