import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  const ProductDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: _size.width,
                  width: _size.width,
                  child: controller.product.images.isEmpty
                      ? const Icon(
                          Icons.shopping_bag,
                          size: 128,
                        )
                      : Image.network(
                          controller.product.images.first,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  controller.product.name,
                                  style: _textTheme.headline5,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  controller.product.description,
                                  style: _textTheme.subtitle1,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$' +
                                    controller.product.priceAfterDiscount
                                        .toString(),
                                style: _textTheme.headline4,
                              ),
                              const SizedBox(height: 4.0),
                              if (controller.product.discount > 0)
                                Text(
                                  '\$' + controller.product.price.toString(),
                                  style: _textTheme.subtitle2!.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'Unit: 1' + controller.product.unit,
                        style: _textTheme.subtitle1,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'In-Stock: ' +
                            controller.product.stockQuantity.toString(),
                        style: _textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => controller.cart.doesExists(controller.product)
                  ? Row(
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              controller.cart.removeItem(controller.product),
                          child: const Icon(Icons.delete),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () =>
                              controller.cart.decreaseItem(controller.product),
                          child: const Icon(Icons.remove),
                        ),
                        Expanded(
                          child: Text(
                            controller.cart
                                .itemCount(controller.product)
                                .toString(),
                            textAlign: TextAlign.center,
                            style: _textTheme.headline6,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              controller.cart.increaseItem(controller.product),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () =>
                          controller.cart.addItem(controller.product),
                      child: const Text('Add to cart'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
