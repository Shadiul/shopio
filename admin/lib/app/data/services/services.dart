import 'package:admin/app/data/services/app_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

export 'app_service.dart';

Future<void> initServices() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => AppService().init());
}
