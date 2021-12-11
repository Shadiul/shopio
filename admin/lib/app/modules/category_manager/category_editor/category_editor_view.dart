import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'category_editor_controller.dart';

class CategoryEditorView extends GetView<CategoryEditorController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isNewMode.value ? 'New Category' : 'Edit Category',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: controller.formKey,
              child: Expanded(
                child: ListView(
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (controller.isNewMode.value)
                  ElevatedButton(
                    onPressed: controller.onTapCreate,
                    child: Text(
                      'Create',
                    ),
                  ),
                if (!controller.isNewMode.value)
                  ElevatedButton(
                    onPressed: controller.onTapUpdate,
                    child: Text(
                      'Update',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
