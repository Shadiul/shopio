import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/models/response_model.dart';
import '../../data/models/user_model.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class AppDrawerController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  UserModel get user => _authService.user!;

  Future<void> onTapLogout() async {
    final ResponseModel _response = await _authService.signOut();
    if (_response.status == ResponseStatus.success) {
      await Get.offAllNamed(Routes.SPLASH);
    }
  }
}
