import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/models/response_model.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Rx<UiState> state = Rx(UiState.idle);

  @override
  Future<void> onReady() async {
    await startApp();
    super.onReady();
  }

  Future<void> startApp() async {
    state.value = UiState.loading;
    await Future.delayed(const Duration(seconds: 1));
    ResponseModel response = await _authService.tryAutoSignIn();
    if (response.status == ResponseStatus.success) {
      await Get.offAndToNamed(Routes.HOME);
    } else {
      await Get.offAndToNamed(Routes.SIGN_IN);
    }
  }

  @override
  void onClose() {}
}
