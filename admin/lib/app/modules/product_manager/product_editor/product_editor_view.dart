import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/enums.dart';
import 'product_editor_controller.dart';

class ProductEditorView extends GetView<ProductEditorController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductEditorController());

    // final themeData = Theme.of(context);
    // final textTheme = themeData.textTheme;

    return AlertDialog(
      scrollable: true,
      title: Obx(
        () => Text(
          controller.isNewMode.value ? 'New Produce' : 'Edit Product',
        ),
      ),
      content: Container(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                    controller: controller.descriptionController,
                    validator: controller.descriptionValidator,
                    decoration: InputDecoration(
                      label: Text('Description'),
                    ),
                  ),
                  TextFormField(
                    controller: controller.categoryController,
                    validator: controller.categoryValidator,
                    readOnly: true,
                    onTap: controller.onTapCategory,
                    decoration: InputDecoration(
                      label: Text('Category'),
                    ),
                  ),
                  TextFormField(
                    controller: controller.unitController,
                    validator: controller.unitValidator,
                    decoration: InputDecoration(
                      label: Text('Unit'),
                      suffix: Text('pcs/g/ml'),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: controller.priceController,
                          validator: controller.priceValidator,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d{1,9}\.?\d{0,2}'),
                            ),
                          ],
                          decoration: InputDecoration(
                            label: Text('Price'),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: controller.discountController,
                          validator: controller.discountValidator,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^[1-9][0-9]?$|^100$'),
                            ),
                          ],
                          decoration: InputDecoration(
                            label: Text('Discount'),
                            suffix: Text('%'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: controller.stockController,
                    validator: controller.stockValidator,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp('[0-9]'),
                      ),
                    ],
                    decoration: InputDecoration(
                      label: Text('Stock'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              height: 128,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: controller.images.length + 1,
                itemBuilder: (context, index) => Card(
                  child: SizedBox(
                    height: 128,
                    width: 128,
                    child: (index > controller.images.length - 1) ||
                            controller.images.isEmpty
                        ? IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add_a_photo_outlined))
                        : Stack(
                            alignment: Alignment.topRight,
                            children: [
                              CachedNetworkImage(
                                imageUrl: controller.images[index],
                              ),
                              Material(
                                color: Colors.transparent,
                                child: IconButton(
                                  onPressed: () {},
                                  color: Colors.red,
                                  icon: Icon(Icons.cancel),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 8),
              ),
            ),
          ],
        ),
      ),
      actionsPadding: EdgeInsets.symmetric(horizontal: 16),
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
          Obx(
            () => controller.uiState == UiState.loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: controller.onTapUpdate,
                    child: Text(
                      'Update',
                    ),
                  ),
          ),
      ],
    );
  }
}
