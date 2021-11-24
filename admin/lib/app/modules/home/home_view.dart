import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/ui_utility.dart';
import '../category_manager/category_manager_view.dart';
import '../dashboard/dashboard_view.dart';
import '../not_found/not_found_view.dart';
import '../sidebar_menu/sidebar_menu_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _size.width <= smallBreakpoint
          ? AppBar(
              title: Obx(
                () => getTitleForSidebarIndex(controller.selectedIndex),
              ),
            )
          : null,
      drawer: _size.width <= smallBreakpoint ? SidebarMenuView() : null,
      body: Row(
        children: [
          if (_size.width > smallBreakpoint) SidebarMenuView(),
          if (_size.width > smallBreakpoint) Divider(),
          Expanded(
            child: Obx(
              () => getViewForSidebarIndex(controller.selectedIndex),
            ),
          ),
        ],
      ),
    );
  }

  Widget getTitleForSidebarIndex(int index) {
    switch (index) {
      case 0:
        return Text('Dashboard');
      case 1:
        return Text('Category Manager');

      default:
        return Container();
    }
  }

  Widget getViewForSidebarIndex(int index) {
    switch (index) {
      case 0:
        return DashboardView();
      case 1:
        return CategoryManagerView();

      default:
        return NotFoundView();
    }
  }
}
