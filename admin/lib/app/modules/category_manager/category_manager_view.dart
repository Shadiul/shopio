import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_manager_controller.dart';
import 'widgets/category_list/category_list_view.dart';

class CategoryManagerView extends GetView<CategoryManagerController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryManagerController());

    // Size _size = MediaQuery.of(context).size;

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Wrap(
            spacing: 16.0,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Categories',
                        style: _textTheme.headline6,
                      ),
                      Text(
                        '100',
                        style: _textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Categories',
                        style: _textTheme.headline6,
                      ),
                      Text(
                        '100',
                        style: _textTheme.headline5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          CategoryListView(),
        ],
      ),
    );
  }
}
