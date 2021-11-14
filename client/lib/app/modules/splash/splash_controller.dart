import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';
import '../../utils/log_colored.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Rx<UiState> state = Rx(UiState.IDLE);

  @override
  Future<void> onReady() async {
    await startApp();
    super.onReady();
  }

  Future<void> startApp() async {
    state.value = UiState.LOADING;
    await Future.delayed(Duration(seconds: 1));

    logColored('🔍 Looking for logged in account', color: LogColor.White);
    await _authService.tryAutoSignIn();
    if (_authService.user == null) {
      await Get.offAndToNamed(Routes.SIGN_IN);
    } else {
      logColored('😀 Found logged in user: ${_authService.user!.email}', color: LogColor.Green);
      await Get.offAndToNamed(Routes.HOME);
    }
  }

  @override
  void onClose() {}
}
