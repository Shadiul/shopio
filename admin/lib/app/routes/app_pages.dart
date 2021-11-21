import 'package:get/get.dart';

import 'package:admin/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:admin/app/modules/dashboard/views/dashboard_view.dart';
import 'package:admin/app/modules/home/bindings/home_binding.dart';
import 'package:admin/app/modules/home/views/home_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
