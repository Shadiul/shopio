import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  final RxInt _bottomNavIndex = RxInt(0);
  int get bottomNavIndex => _bottomNavIndex.value;
  set bottomNavIndex(int value) {
    _bottomNavIndex.value = value;
  }
}
