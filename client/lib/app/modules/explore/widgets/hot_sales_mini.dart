import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../explore_controller.dart';

class HotSalesMiniWidget extends GetWidget<ExploreController> {
  const HotSalesMiniWidget({Key? key}) : super(key: key);

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
                  'Hot Sales',
                  style: _textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('see more'),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: const SizedBox(
            height: 200.0,
            width: double.infinity,
            child: Card(
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
