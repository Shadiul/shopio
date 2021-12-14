import 'package:admin/app/data/enums.dart';
import 'package:admin/app/data/models/response_model.dart';
import 'package:admin/app/data/services/firebase_storage_service.dart';
import 'package:admin/app/data/services/firestore_service.dart';
import 'package:get/get.dart';

class IconPickerController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final FirebaseStorageService _firebaseStorageService =
      Get.find<FirebaseStorageService>();

  RxList<String> icons = RxList();

  @override
  Future<void> onInit() async {
    await fetchCatagoryIcons();
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  Future<void> fetchCatagoryIcons() async {
    _uiState.value = UiState.loading;
    List<String> _icons = [];
    final response = await _firestoreService.getCategoryIcons();
    if (response.status == ResponseStatus.success) {
      for (final iconPath in response.data as List<String>) {
        final response = await convertPathToUri(iconPath);
        if (response.status == ResponseStatus.success) {
          _icons.add(response.data);
        }
      }
      icons.value = _icons;
      _uiState.value = UiState.success;
    } else {
      _uiState.value = UiState.error;
    }
  }

  Future<ResponseModel> convertPathToUri(String path) async {
    return await _firebaseStorageService.getDownloadUrl(path);
  }

  Future<void> onTapIcon(index) async {
    Get.back(result: icons[index]);
  }
}
