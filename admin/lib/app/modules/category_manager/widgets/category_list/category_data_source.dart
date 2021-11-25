import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_list_controller.dart';

class CategoryDataSource extends DataTableSource {
  final BuildContext context;

  CategoryDataSource(this.context);

  final CategoryListController controller = Get.find<CategoryListController>();

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: index % 2 == 0
          ? MaterialStateProperty.all(Theme.of(context).highlightColor)
          : null,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(controller.categories[index].id)),
        DataCell(Text(controller.categories[index].name)),
        DataCell(
          Text(
            controller.categories[index].productsCount.toString(),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                onPressed: () {
                  controller.deleteItem(index);
                  notifyListeners();
                },
                icon: Icon(Icons.delete),
                color: Colors.redAccent.shade200,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.categories.length;

  @override
  int get selectedRowCount => 0;
}
