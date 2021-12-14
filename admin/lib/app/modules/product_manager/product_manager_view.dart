import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'product_manager_controller.dart';
import 'widgets/products_data_table/products_data_table_view.dart';

class ProductManagerView extends GetView<ProductManagerController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductManagerController());

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ProductsDataTableView(),
        ],
      ),
    );
  }
}
