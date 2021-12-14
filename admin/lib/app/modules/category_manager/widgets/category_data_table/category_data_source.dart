import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'category_data_table_controller.dart';

class CategoryDataSource extends DataTableSource {
  final BuildContext context;

  CategoryDataSource(this.context);

  final CategoryDataTableController controller =
      Get.find<CategoryDataTableController>();

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      color: index % 2 == 0
          ? MaterialStateProperty.all(Theme.of(context).highlightColor)
          : null,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          Row(
            children: [
              Text(controller.categories[index].id),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy),
              ),
            ],
          ),
        ),
        DataCell(
          Text(
            DateFormat('MMM dd, yyyy hh:mm a').format(
              controller.categories[index].timestamp.toDate(),
            ),
          ),
        ),
        DataCell(
          Text(controller.categories[index].name),
        ),
        DataCell(
          Text(
            controller.categories[index].productsCount.toString(),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  await controller.onTapEditCategory(index);
                  notifyListeners();
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  await controller.deleteItem(index);
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

  Future<void> addRow(int index) async {
    await controller.onTapAddCategory();
    notifyListeners();
  }

  void sortByTimestamp(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.categories.sort(
      (a, b) => b.timestamp.compareTo(
        a.timestamp,
      ),
    );
    if (!ascending) {
      controller.categories.value = controller.categories.reversed.toList();
    }
    notifyListeners();
  }

  void sortByName(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.categories.sort(
      (a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
    );
    if (!ascending) {
      controller.categories.value = controller.categories.reversed.toList();
    }
    notifyListeners();
  }

  void sortByProductCount(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.categories.sort(
      (a, b) => b.productsCount.compareTo(
        a.productsCount,
      ),
    );
    if (!ascending) {
      controller.categories.value = controller.categories.reversed.toList();
    }
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.categories.length;

  @override
  int get selectedRowCount => 0;
}
