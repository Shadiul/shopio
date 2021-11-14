import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class SignInController extends GetxController {
  Future<void> onTapSignIn() async {
    await Get.offNamed(Routes.HOME);
  }

  Future<void> onTapCreateAnAccount() async {
    await Get.offNamed(Routes.SIGN_UP);
  }
}
