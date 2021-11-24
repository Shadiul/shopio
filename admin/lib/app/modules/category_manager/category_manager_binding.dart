import 'package:get/get.dart';

import 'category_manager_controller.dart';

class CategoryManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryManagerController>(
      () => CategoryManagerController(),
    );
  }
}
