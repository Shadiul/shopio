import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../dashboard/views/dashboard_view.dart';
import '../../sidebar_menu/sidebar_menu_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          if (_size.width > 1000) SidebarMenuView(),
          if (_size.width > 1000) Divider(),
          Expanded(
            child: Obx(
              () => getViewForSidebarIndex(controller.selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget getViewForSidebarIndex(int index) {
    switch (index) {
      case 0:
        return DashboardView();
      case 1:
        return Container(
          child: Center(
            child: Text(index.toString()),
          ),
        );

      default:
        return Container(
          child: Center(
            child: Text(index.toString()),
          ),
        );
    }
  }
}
