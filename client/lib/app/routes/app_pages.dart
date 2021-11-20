import 'package:get/get.dart';

import 'package:client/app/modules/cart/cart_binding.dart';
import 'package:client/app/modules/cart/cart_view.dart';
import 'package:client/app/modules/product_details/product_details_binding.dart';
import 'package:client/app/modules/product_details/product_details_view.dart';
import 'package:client/app/modules/product_list/product_list_binding.dart';
import 'package:client/app/modules/product_list/product_list_view.dart';

import '../modules/account/account_binding.dart';
import '../modules/account/account_view.dart';
import '../modules/explore/explore_binding.dart';
import '../modules/explore/explore_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/sign_in/sign_in_binding.dart';
import '../modules/sign_in/sign_in_view.dart';
import '../modules/sign_up/sign_up_binding.dart';
import '../modules/sign_up/sign_up_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';

// ignore_for_file: constant_identifier_names, prefer_const_constructors

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE,
      page: () => ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: _Paths.ACCOUNT,
      page: () => AccountView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_LIST,
      page: () => ProductListView(),
      binding: ProductListBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      page: () => ProductDetailsView(),
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
  ];
}
