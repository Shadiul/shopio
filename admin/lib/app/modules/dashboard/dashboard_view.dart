import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    Size _size = MediaQuery.of(context).size;

    return Center(
      child: Text(
        'DashboardView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
