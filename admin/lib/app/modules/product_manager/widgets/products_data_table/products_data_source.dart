import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'products_data_table_controller.dart';

class ProductsDataSource extends DataTableSource {
  final ProductsDataTableController controller =
      Get.find<ProductsDataTableController>();

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          Row(
            children: [
              Text(controller.products[index].id),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy),
              ),
            ],
          ),
        ),
        DataCell(
          Text(controller.products[index].name),
        ),
        DataCell(
          Text(controller.products[index].price.toString() + r' $'),
        ),
        DataCell(
          Text(controller.products[index].discount.toString() + '%'),
        ),
        DataCell(
          Text(
              controller.products[index].priceAfterDiscount.toString() + r' $'),
        ),
        DataCell(
          Text(controller.products[index].stockQuantity.toString()),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  await controller.onTapEditProduct(index);
                  notifyListeners();
                },
                icon: Icon(Icons.edit_outlined),
              ),
              IconButton(
                onPressed: () async {
                  await controller.deleteItem(index);
                  notifyListeners();
                },
                icon: Icon(Icons.delete_outline),
                color: Colors.redAccent.shade200,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> addRow(int index) async {
    await controller.onTapAddProduct();
    notifyListeners();
  }

  void sortByName(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.products.sort(
      (a, b) => a.name.toLowerCase().compareTo(
            b.name.toLowerCase(),
          ),
    );
    if (!ascending) {
      controller.products.value = controller.products.reversed.toList();
    }
    notifyListeners();
  }

  void sortByPrice(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.products.sort(
      (a, b) => b.price.compareTo(
        a.price,
      ),
    );
    if (!ascending) {
      controller.products.value = controller.products.reversed.toList();
    }
    notifyListeners();
  }

  void sortByDiscount(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.products.sort(
      (a, b) => b.discount.compareTo(
        a.discount,
      ),
    );
    if (!ascending) {
      controller.products.value = controller.products.reversed.toList();
    }
    notifyListeners();
  }

  void sortByDiscountedPrice(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.products.sort(
      (a, b) => b.priceAfterDiscount.compareTo(
        a.priceAfterDiscount,
      ),
    );
    if (!ascending) {
      controller.products.value = controller.products.reversed.toList();
    }
    notifyListeners();
  }

  void sortByStock(columnIndex, ascending) {
    controller.sortColumnIndex.value = columnIndex;
    controller.sortAscending.value = ascending;
    controller.products.sort(
      (a, b) => b.stockQuantity.compareTo(
        a.stockQuantity,
      ),
    );
    if (!ascending) {
      controller.products.value = controller.products.reversed.toList();
    }
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.products.length;

  @override
  int get selectedRowCount => 0;
}
