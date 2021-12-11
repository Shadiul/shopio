import 'package:get/get.dart';

import 'category_editor_controller.dart';

class CategoryEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CategoryEditorController>(CategoryEditorController());
  }
}
