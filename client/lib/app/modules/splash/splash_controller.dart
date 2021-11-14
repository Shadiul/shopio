import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  Future<void> onReady() async {
    await startApp();
    super.onReady();
  }

  Future<void> startApp() async {
    await Future.delayed(Duration(seconds: 2));
    await Get.offAndToNamed(Routes.HOME);
  }

  @override
  void onClose() {}
}
