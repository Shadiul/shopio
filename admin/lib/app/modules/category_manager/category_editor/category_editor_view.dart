import 'package:admin/app/data/enums.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'category_editor_controller.dart';

class CategoryEditorView extends GetView<CategoryEditorController> {
  @override
  Widget build(BuildContext context) {
    Get.put(CategoryEditorController());

    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;

    return AlertDialog(
      scrollable: true,
      content: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Icon',
              style: textTheme.bodyText2,
            ),
            IconButton(
              onPressed: controller.onTapIconPicker,
              iconSize: 64,
              icon: Obx(
                () => CachedNetworkImage(
                  imageUrl: controller.icon,
                  color: themeData.colorScheme.primary,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Form(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.nameController,
                    validator: controller.nameValidator,
                    decoration: InputDecoration(
                      label: Text('Name'),
                    ),
                  ),
                  TextFormField(
                    controller: controller.productsCountController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                    ],
                    decoration: InputDecoration(
                      label: Text('Products Count'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: Text('Cancel'),
        ),
        if (controller.isNewMode.value)
          Obx(
            () => controller.uiState == UiState.loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: controller.onTapCreate,
                    child: Text(
                      'Create',
                    ),
                  ),
          ),
        if (!controller.isNewMode.value)
          Obx(() => controller.uiState == UiState.loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: controller.onTapUpdate,
                  child: Text(
                    'Update',
                  ),
                )),
      ],
    );
  }
}
