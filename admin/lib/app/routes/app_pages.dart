import 'package:get/get.dart';

import '../modules/category_manager/category_editor/category_editor_binding.dart';
import '../modules/category_manager/category_editor/category_editor_view.dart';
import '../modules/category_manager/category_manager_binding.dart';
import '../modules/category_manager/category_manager_view.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/not_found/not_found_binding.dart';
import '../modules/not_found/not_found_view.dart';
import '../modules/product_manager/product_manager_binding.dart';
import '../modules/product_manager/product_manager_view.dart';

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
    GetPage(
      name: _Paths.NOT_FOUND,
      page: () => NotFoundView(),
      binding: NotFoundBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_MANAGER,
      page: () => CategoryManagerView(),
      binding: CategoryManagerBinding(),
      children: [
        GetPage(
          name: _Paths.CATEGORY_EDITOR,
          page: () => CategoryEditorView(),
          binding: CategoryEditorBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCT_MANAGER,
      page: () => ProductManagerView(),
      binding: ProductManagerBinding(),
    ),
  ];
}
