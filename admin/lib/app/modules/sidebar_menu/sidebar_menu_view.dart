import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sidebar_menu_controller.dart';

class SidebarMenuView extends GetView<SidebarMenuController> {
  const SidebarMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SidebarMenuController>()) {
      Get.put(SidebarMenuController());
    }
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text('Admin@email.com'),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  onTap: () => controller.selectedIndex = 0,
                  selected: controller.selectedIndex == 0,
                  leading: Icon(Icons.dashboard),
                  title: Text('Dasshboard'),
                ),
                ListTile(
                  onTap: () => controller.selectedIndex = 1,
                  selected: controller.selectedIndex == 1,
                  leading: Icon(Icons.ac_unit),
                  title: Text('Menu Item 2'),
                ),
                ListTile(
                  onTap: () => controller.selectedIndex = 2,
                  selected: controller.selectedIndex == 2,
                  leading: Icon(Icons.ac_unit),
                  title: Text('Menu Item 3'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
