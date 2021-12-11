import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'product_manager_controller.dart';

class ProductManagerView extends GetView<ProductManagerController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductManagerController());

    return Scaffold(
      body: Obx(
        () => GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisExtent: 200,
          ),
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            final product = controller.products[index];
            return ListTile(
              onTap: () {},
              leading: product.images.isEmpty
                  ? Icon(Icons.image)
                  : SizedBox(
                      height: 64,
                      width: 64,
                      child: CachedNetworkImage(
                        imageUrl: product.images.first,
                      ),
                    ),
              title: Text(product.name),
              subtitle: Text(product.description),
            );
          },
        ),
      ),
    );
  }
}
