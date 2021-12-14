import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/enums.dart';
import 'icon_picker_controller.dart';

class IconPickerView extends GetView<IconPickerController> {
  const IconPickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(IconPickerController());

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
              : GridView.builder(
                  padding: EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemCount: controller.icons.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () async => controller.onTapIcon(index),
                    child: CachedNetworkImage(
                      imageUrl: controller.icons[index],
                      color: themeData.colorScheme.primary,
                      height: 48,
                      width: 48,
                      fit: BoxFit.contain,
                    ),
                  ),
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
