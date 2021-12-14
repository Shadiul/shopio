import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums.dart';
import 'category_picker_controller.dart';

class CategoryPickerView extends GetView<CategoryPickerController> {
  const CategoryPickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CategoryPickerController());

    final themeData = Theme.of(context);

    return AlertDialog(
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        height: 400,
        width: 400,
        child: Obx(
          () => controller.uiState == UiState.loading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: controller.categories
                      .map(
                        (element) => ListTile(
                          onTap: () async => controller.onTapCategory(element),
                          leading: CachedNetworkImage(
                            imageUrl: element.icon,
                            height: 48,
                            width: 48,
                            color: themeData.colorScheme.primary,
                          ),
                          title: Text(element.name),
                          subtitle: Text(element.id),
                        ),
                      )
                      .toList(),
                ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
