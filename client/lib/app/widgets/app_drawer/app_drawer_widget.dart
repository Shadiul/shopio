import 'package:client/app/widgets/app_drawer/app_drawer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawerWidget extends GetView<AppDrawerController> {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AppDrawerController());

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
