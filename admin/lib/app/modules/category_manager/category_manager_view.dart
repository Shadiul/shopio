import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_manager_controller.dart';
import 'widgets/category_list/category_list_view.dart';

class CategoryManagerView extends GetView<CategoryManagerController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryManagerController());

    // Size _size = MediaQuery.of(context).size;

    // ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          CategoryListView(),
        ],
      ),
    );
  }
}
