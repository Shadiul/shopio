import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/ui_utility.dart';
import '../sidebar_menu/sidebar_menu_view.dart';
import 'not_found_controller.dart';

class NotFoundView extends GetView<NotFoundController> {
  final bool showAppBar;

  NotFoundView({
    this.showAppBar = false,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(NotFoundController());

    Size _size = MediaQuery.of(context).size;

    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      appBar: showAppBar ? AppBar() : null,
      drawer: _size.width <= smallBreakpoint ? SidebarMenuView() : null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '404',
            textAlign: TextAlign.center,
            style: _textTheme.headline2,
          ),
          Text(
            'Page not found',
            textAlign: TextAlign.center,
            style: _textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
