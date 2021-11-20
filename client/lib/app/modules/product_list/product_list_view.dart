import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/models.dart';
import '../../widgets/product_card_widget.dart';
import 'product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.category != null
              ? Text(controller.category!.name)
              : Container(),
        ),
      ),
      body: Obx(
        () => GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              // childAspectRatio: 9 / 16,
              mainAxisExtent: 220,
            ),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              ProductModel product = controller.products[index];
              return ProductCardWidget(
                product: product,
                onTap: () async => controller.onTapProduct(product),
              );
            }),
      ),
    );
  }
}
