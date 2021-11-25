import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../data/services/services.dart';
import '../icon_picker.dart';
import 'category_list_controller.dart';

class CategoryDataSource extends DataTableSource {
  final BuildContext context;

  CategoryDataSource(this.context);

  final CategoryListController controller = Get.find<CategoryListController>();
  final FirebaseStorageService _firebaseStorageService =
      Get.find<FirebaseStorageService>();

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
          FutureBuilder<String>(
            future: _firebaseStorageService
                .getDownloadUrl(controller.categories[index].icon),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CachedNetworkImage(
                  imageUrl: snapshot.data!,
                  cacheKey: controller.categories[index].icon,
                  color: Theme.of(context).colorScheme.primary,
                  height: 48.0,
                  width: 48.0,
                );
              }
              return CircularProgressIndicator();
            },
          ),
          onTap: () async {
            String? icon = await showDialog(
              context: context,
              builder: (context) {
                return IconPicker();
              },
            );

            if (icon != null) {
              await controller.updateIcon(index, icon);
              notifyListeners();
            }
          },
        ),
        DataCell(Text(controller.categories[index].id)),
        DataCell(
          Text(
            DateFormat('MMM dd, yyyy hh:mm:ss a').format(
              controller.categories[index].timestamp.toDate(),
            ),
          ),
        ),
        DataCell(
          TextFormField(
            key: Key(controller.categories[index].id),
            initialValue: controller.categories[index].name,
            maxLength: 30,
            keyboardType: TextInputType.text,
            onFieldSubmitted: (value) async {
              await controller.updateName(index, value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              counterText: '',
            ),
          ),
          showEditIcon: true,
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
    await controller.addCategory();
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
