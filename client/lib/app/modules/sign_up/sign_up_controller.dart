import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class SignUpController extends GetxController {
  Future<void> onTapSignUp() async {
    await Get.offNamed(Routes.HOME);
  }

  Future<void> onTapAlreadyHaveAnAccount() async {
    await Get.offNamed(Routes.SIGN_IN);
  }
}
