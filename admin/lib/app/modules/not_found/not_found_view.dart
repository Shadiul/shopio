import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sidebar_menu/sidebar_menu_view.dart';
import 'not_found_controller.dart';

class NotFoundView extends GetView<NotFoundController> {
  @override
  Widget build(BuildContext context) {
    Get.put(NotFoundController());

    Size _size = MediaQuery.of(context).size;

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      appBar: AppBar(),
      drawer: _size.width <= 1000 ? SidebarMenuView() : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '404',
            textAlign: TextAlign.center,
            style: _textTheme.headline1,
          ),
          Text(
            'Page not found',
            textAlign: TextAlign.center,
            style: _textTheme.headline3,
          ),
        ],
      ),
    );
  }
}
