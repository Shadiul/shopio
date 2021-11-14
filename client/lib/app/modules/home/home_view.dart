import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/app_drawer/app_drawer_widget.dart';
import '../explore/explore_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: const AppDrawerWidget(),
      body: Column(
        children: [
          const Expanded(child: ExploreView()),
          Container(
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
                    title: const Text('Wishlist'),
                    icon: const Icon(Icons.favorite),
                  ),
                  SalomonBottomBarItem(
                    title: const Text('Account'),
                    icon: const Icon(Icons.account_circle),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
