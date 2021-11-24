import 'package:get/get.dart';

import '../../data/services/services.dart';

class HomeController extends GetxController {
  final AppService _appService = Get.find<AppService>();

  int get selectedIndex => _appService.selectedSidebarMenuIndex;
}
