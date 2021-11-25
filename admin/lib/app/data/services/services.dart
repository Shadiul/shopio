import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app_service.dart';
import 'firestore_service.dart';

export 'app_service.dart';
export 'firestore_service.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Get.putAsync(() => FirestoreService().init());

  await Get.putAsync(() => AppService().init());
}
