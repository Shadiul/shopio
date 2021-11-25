import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums.dart';
import '../catagory_form_view.dart/category_form_controller.dart';
import '../catagory_form_view.dart/category_form_view.dart';
import 'category_data_source.dart';
import 'category_list_controller.dart';

class CategoryListView extends GetView<CategoryListController> {
  const CategoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryListController());

    // ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search),
                ),
                IconButton(
                  onPressed: () async {
                    Get.replace(CategoryFormController());
                    await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => CategoryFormView(),
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ],
              columns: [
                DataColumn(label: Text('Index')),
                DataColumn(label: Text('ID')),
                DataColumn(
                  label: Text('Name'),
                  onSort: controller.sortByName,
                ),
                DataColumn(
                  label: Text('Products Count'),
                  numeric: true,
                  onSort: controller.sortByProductCount,
                ),
                DataColumn(label: Text('Menu'), numeric: true),
              ],
              source: CategoryDataSource(context),
            ),
    );
  }
}
