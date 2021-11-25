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

    // ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

    CategoryDataSource dataSource = CategoryDataSource(context);

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
              key: ObjectKey(controller.categories),
              sortColumnIndex: controller.sortColumnIndex.value,
              sortAscending: controller.sortAscending.value,
              showFirstLastButtons: true,
              header: Text('Categories'),
              columnSpacing: 24.0,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () async {
                    await dataSource.addRow(0);
                  },
                  icon: Icon(Icons.add),
                ),
              ],
              columns: [
                DataColumn(label: Text('Index')),
                DataColumn(label: Text('Icon')),
                DataColumn(label: Text('ID')),
                DataColumn(
                  label: Text('Timestamp'),
                ),
                DataColumn(
                  label: Text('Name'),
                  onSort: dataSource.sortByName,
                ),
                DataColumn(
                  label: Text('Products Count'),
                  numeric: true,
                  onSort: dataSource.sortByProductCount,
                ),
                DataColumn(label: Text('Menu'), numeric: true),
              ],
              source: dataSource,
            ),
    );
  }
}
