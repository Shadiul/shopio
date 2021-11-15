import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/enums.dart';
import '../../../data/models/category_model.dart';
import '../explore_controller.dart';

class CategoryMiniWidget extends GetWidget<ExploreController> {
  const CategoryMiniWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 0.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Select Category',
                  style: _textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('view all'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120.0,
          child: Obx(
            () => controller.categoriesState.value == UiState.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      CategoryModel category = controller.categories[index];

                      return SizedBox(
                        width: 64,
                        child: Column(
                          children: [
                            MaterialButton(
                              onPressed: () {},
                              shape: const CircleBorder(),
                              color: _themeData.colorScheme.primary,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: const EdgeInsets.all(16.0),
                              child: Image.asset(
                                'assets/icons/${category.icon}.png',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Expanded(
                              child: Text(
                                category.name,
                                textAlign: TextAlign.center,
                                style: _textTheme.subtitle2,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 8.0),
                  ),
          ),
        ),
      ],
    );
  }
}
