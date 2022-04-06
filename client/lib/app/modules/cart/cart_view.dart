import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/models.dart';
import 'cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              itemCount: controller.cart.items.length,
              itemBuilder: (context, index) {
                ProductModel product = controller.cart.items[index].product;
                CartItemModel cartItem = controller.cart.items[index];
                return ListTile(
                  onTap: () async => controller.onTapCartItem(product),
                  leading: product.images.isEmpty
                      ? const Icon(
                          Icons.shopping_bag,
                          size: 128,
                        )
                      : Image.network(
                          product.images.first,
                          fit: BoxFit.cover,
                        ),
                  title: Text(product.name),
                  subtitle: Obx(
                    () => Text('Quantity: ' + cartItem.quantity.toString()),
                  ),
                  trailing: Obx(
                    () => Text('\$' + cartItem.totalPrice.toString()),
                  ),
                );
              },
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          child: Obx(
            () => Text(
              'Total: ' + controller.cart.totalPrice.toString(),
              textAlign: TextAlign.end,
              style: _textTheme.subtitle1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: controller.onTapPlaceOrder,
            child: const Text('Place Order'),
          ),
        ),
      ],
    );
  }
}
