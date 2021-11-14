import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      body: Center(
        child: Text(
          'Shopio',
          style: _textTheme.headline2!.copyWith(
            color: _themeData.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
