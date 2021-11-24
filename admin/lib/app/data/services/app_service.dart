import 'package:get/get.dart';

class AppService extends GetxService {
  Future<AppService> init() async {
    return this;
  }

  final RxInt _selectedSidebarMenuIndex = RxInt(0);
  int get selectedSidebarMenuIndex => _selectedSidebarMenuIndex.value;
  set selectedSidebarMenuIndex(int value) {
    if (value >= 0) {
      _selectedSidebarMenuIndex.value = value;
    }
  }
}
