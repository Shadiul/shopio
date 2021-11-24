import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    Size _size = MediaQuery.of(context).size;

    return Container(
      child: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 16 / 9,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => Card(),
      ),
    );
  }
}
