import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../../widgets/bottom_nav_bar/bottom_nav_bar_widget.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavBarController());

    ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.getAppBarTitle(),
          ),
        ),
      ),
      body: Obx(
        () => PageTransitionSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation, secondaryAnimation) =>
              SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.scaled,
            fillColor: _themeData.scaffoldBackgroundColor,
            child: Material(
              color: Colors.transparent,
              elevation: 0.0,
              child: child,
            ),
          ),
          child: controller.getBodyView(),
        ),
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
