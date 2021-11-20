import 'package:client/app/data/models/cart_model/cart_model.dart';
import 'package:get/get.dart';

class CartService extends GetxService {
  Future<CartService> init() async {
    return this;
  }

  final Rx<CartModel> _cart = Rx<CartModel>(CartModel());
  CartModel get cart => _cart.value;
}
