import 'package:flutter/material.dart';

import '../../../../data/models/category_model.dart';

class CategoryDataSource extends DataTableSource {
  final List<CategoryModel> categories;
  final Function(int index)? onDelete;
  // final BuildContext context;

  CategoryDataSource({
    this.onDelete,
    this.categories = const [],
  });
  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      // color: index % 2 == 0
      //     ? MaterialStateProperty.all(Theme.of(context).highlightColor)
      //     : null,
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(Text(categories[index].id)),
        DataCell(Text(categories[index].name)),
        DataCell(
          Text(
            categories[index].productsCount.toString(),
          ),
        ),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              IconButton(
                onPressed: onDelete == null
                    ? null
                    : () {
                        onDelete!(index);
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
  int get rowCount => categories.length;

  @override
  int get selectedRowCount => 0;
}
