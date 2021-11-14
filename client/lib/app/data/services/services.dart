import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/log_colored.dart';
import 'auth_service.dart';

export 'auth_service.dart';

Future<void> initServices() async {
  logColored('📦 Starting services', color: LogColor.White);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(() => AuthService().init());
  logColored('✔️ All Service Started', color: LogColor.White);
}
