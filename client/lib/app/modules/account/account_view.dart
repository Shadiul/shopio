import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AccountController());

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return ListView(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      children: [
        const CircleAvatar(
          radius: 48.0,
          child: Icon(
            Icons.account_circle,
            size: 64.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          controller.user.name,
          textAlign: TextAlign.center,
          style: _textTheme.headline6,
        ),
        const SizedBox(height: 8.0),
        Text(
          controller.user.email,
          textAlign: TextAlign.center,
          style: _textTheme.subtitle1,
        ),
        const SizedBox(height: 16.0),
        const Divider(height: 0),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.delivery_dining),
          title: const Text('My Orders'),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.edit),
          title: const Text('Edit Profile'),
          trailing: const Icon(Icons.chevron_right),
        ),
        ListTile(
          onTap: controller.onTapLogout,
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
        ),
      ],
    );
  }
}
