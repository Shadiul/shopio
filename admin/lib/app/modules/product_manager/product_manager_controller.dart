import 'package:get/get.dart';

import '../../data/enums.dart';

class ProductManagerController extends GetxController {
  // final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _uiState.value = UiState.loading;
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;
}
