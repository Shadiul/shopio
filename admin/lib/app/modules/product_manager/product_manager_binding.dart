import 'package:get/get.dart';

import 'product_manager_controller.dart';

class ProductManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductManagerController>(
      () => ProductManagerController(),
    );
  }
}
