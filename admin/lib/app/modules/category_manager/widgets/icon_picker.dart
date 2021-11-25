import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/services.dart';
import 'category_list/category_list_controller.dart';

class IconPicker extends GetWidget<CategoryListController> {
  IconPicker({Key? key}) : super(key: key);

  final FirebaseStorageService _firebaseStorageService =
      Get.find<FirebaseStorageService>();

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;
    return AlertDialog(
      scrollable: true,
      content: Container(
        height: 500.0,
        width: 500.0,
        child: Obx(() => GridView.builder(
              itemCount: controller.categoryIcons.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 48.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return FutureBuilder<String>(
                  future: _firebaseStorageService
                      .getDownloadUrl(controller.categoryIcons[index]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(
                              context, controller.categoryIcons[index]);
                        },
                        onHover: (value) {},
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data!,
                          color: Theme.of(context).colorScheme.primary,
                          height: 48.0,
                          width: 48.0,
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                );
              },
            )),
      ),
    );
  }
}
