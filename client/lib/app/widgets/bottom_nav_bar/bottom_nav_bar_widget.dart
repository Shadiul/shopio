import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'bottom_nav_bar_controller.dart';

class BottomNavBarWidget extends GetView<BottomNavBarController> {
  const BottomNavBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

    return Container(
      decoration: BoxDecoration(
        color: _themeData.colorScheme.primaryVariant,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      child: Obx(
        () => SalomonBottomBar(
          currentIndex: controller.bottomNavIndex,
          onTap: (value) => controller.bottomNavIndex = value,
          selectedItemColor: _themeData.colorScheme.onPrimary,
          unselectedItemColor: _themeData.colorScheme.onPrimary,
          items: [
            SalomonBottomBarItem(
              title: const Text('Explore'),
              icon: const Icon(Icons.explore),
            ),
            SalomonBottomBarItem(
              title: const Text('Cart'),
              icon: const Icon(Icons.shopping_cart),
            ),
            SalomonBottomBarItem(
              title: const Text('Account'),
              icon: const Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}
