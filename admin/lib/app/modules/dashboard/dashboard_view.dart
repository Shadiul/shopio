import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sidebar_menu/sidebar_menu_view.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _size.width <= 1000
          ? AppBar(
              title: Text('DashboardView'),
              centerTitle: true,
            )
          : null,
      drawer: _size.width <= 1000 ? SidebarMenuView() : null,
      body: Center(
        child: Text(
          'DashboardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
