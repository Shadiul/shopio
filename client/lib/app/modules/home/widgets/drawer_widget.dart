import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home_controller.dart';

class DrawerWidget extends GetWidget<HomeController> {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('User name'),
            accountEmail: Text(controller.user.email),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            margin: EdgeInsets.zero,
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  onTap: controller.onTapLogout,
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
