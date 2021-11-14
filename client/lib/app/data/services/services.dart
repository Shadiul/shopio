import 'package:get/get.dart';

import '../../utils/log_colored.dart';
import 'auth_service.dart';

export 'auth_service.dart';

Future<void> initServices() async {
  logColored('📦 Starting services', color: LogColor.White);
  await Get.putAsync(() => AuthService().init());
  logColored('✔️ All Service Started', color: LogColor.White);
}
