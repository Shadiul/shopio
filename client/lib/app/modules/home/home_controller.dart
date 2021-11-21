import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../widgets/bottom_nav_bar/bottom_nav_bar_controller.dart';
import '../account/account_view.dart';
import '../cart/cart_view.dart';
import '../explore/explore_view.dart';

class HomeController extends GetxController {
  final BottomNavBarController _bottomNavBarController =
      Get.find<BottomNavBarController>();

  int get bottomNavIndex => _bottomNavBarController.bottomNavIndex;

  String getAppBarTitle() {
    switch (bottomNavIndex) {
      case 0:
        return 'Explore';
      case 1:
        return 'Cart';
      case 2:
        return 'Wishlist';
      case 3:
        return 'Account';
      default:
        return '';
    }
  }

  Widget getBodyView() {
    switch (bottomNavIndex) {
      case 0:
        return const ExploreView();
      case 1:
        return const CartView();
      case 2:
        return Container();
      case 3:
        return const AccountView();
      default:
        return Container();
    }
  }
}
