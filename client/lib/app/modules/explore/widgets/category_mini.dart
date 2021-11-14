import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            itemCount: 10,
            itemBuilder: (context, index) => SizedBox(
              width: 64,
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 32.0,
                    child: Icon(Icons.shop),
                  ),
                  const SizedBox(height: 4.0),
                  Expanded(
                    child: Text(
                      'Category name',
                      textAlign: TextAlign.center,
                      style: _textTheme.subtitle2,
                    ),
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(width: 8.0),
          ),
        ),
      ],
    );
  }
}
