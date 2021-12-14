import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums.dart';
import 'products_data_source.dart';
import 'products_data_table_controller.dart';

class ProductsDataTableView extends GetView<ProductsDataTableController> {
  const ProductsDataTableView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductsDataTableController());

    // ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;
    // final size = MediaQuery.of(context).size;

    ProductsDataSource dataSource = ProductsDataSource();

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
              key: ObjectKey(controller.products),
              sortColumnIndex: controller.sortColumnIndex.value,
              sortAscending: controller.sortAscending.value,
              showFirstLastButtons: true,
              header: Text('Products'),
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
                DataColumn(
                  label: Text('Index'),
                  numeric: true,
                ),
                DataColumn(label: Text('ID')),
                DataColumn(
                  label: Text('Name'),
                  onSort: dataSource.sortByName,
                ),
                DataColumn(
                  label: Text('Price'),
                  numeric: true,
                  onSort: dataSource.sortByPrice,
                ),
                DataColumn(
                  label: Text('Discount'),
                  numeric: true,
                  onSort: dataSource.sortByDiscount,
                ),
                DataColumn(
                  label: Text('Discounted\nPrice'),
                  numeric: true,
                  onSort: dataSource.sortByDiscountedPrice,
                ),
                DataColumn(
                  label: Text('Stock'),
                  numeric: true,
                  onSort: dataSource.sortByStock,
                ),
                DataColumn(label: Text('Menu'), numeric: true),
              ],
              source: dataSource,
            ),
    );
  }
}
