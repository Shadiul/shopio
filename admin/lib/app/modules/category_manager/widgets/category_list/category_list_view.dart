import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums.dart';
import 'category_data_source.dart';
import 'category_list_controller.dart';

class CategoryListView extends GetView<CategoryListController> {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryListController());

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Obx(
      () => controller.uiState == UiState.loading
          ? Card(
              child: Container(
                height: 500.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : PaginatedDataTable(
              sortColumnIndex: controller.sortColumnIndex.value,
              sortAscending: controller.sortAscending.value,
              showFirstLastButtons: true,
              header: Text('Categories'),
              actions: [
                SizedBox(
                  width: 200.0,
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: _themeData.highlightColor,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              ],
              columns: [
                DataColumn(
                  label: Text('Index'),
                ),
                DataColumn(label: Text('ID')),
                DataColumn(
                  label: Text('Name'),
                  onSort: (columnIndex, ascending) {
                    controller.sortColumnIndex.value = columnIndex;
                    controller.sortAscending.value = ascending;
                    controller.categories.sort(
                      (a, b) => a.name.toLowerCase().compareTo(
                            b.name.toLowerCase(),
                          ),
                    );
                    if (!ascending) {
                      controller.categories.value =
                          controller.categories.reversed.toList();
                    }
                  },
                ),
                DataColumn(
                  label: Text('Products Count'),
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    controller.sortColumnIndex.value = columnIndex;
                    controller.sortAscending.value = ascending;
                    controller.categories.sort(
                      (a, b) => b.productsCount.compareTo(
                        a.productsCount,
                      ),
                    );
                    if (!ascending) {
                      controller.categories.value =
                          controller.categories.reversed.toList();
                    }
                  },
                ),
                DataColumn(label: Text('Menu'), numeric: true),
              ],
              source: CategoryDataSource(context, controller.categories),
            ),
    );
  }
}
