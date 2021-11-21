import 'package:admin/app/modules/dashboard/views/dashboard_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(),
          Divider(),
          Expanded(
            child: Container(
              child: DashboardView(),
            ),
          ),
        ],
      ),
    );
  }
}
