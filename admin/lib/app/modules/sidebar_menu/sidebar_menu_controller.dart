import 'package:get/get.dart';

import '../../data/services/services.dart';

class SidebarMenuController extends GetxController {
  final AppService _appService = Get.find<AppService>();

  int get selectedIndex => _appService.selectedSidebarMenuIndex;
  set selectedIndex(int value) => _appService.selectedSidebarMenuIndex = value;
}
