import 'package:get/get.dart';

import '../../../../data/enums.dart';
import '../../../../data/models/models.dart';
import '../../../../data/services/services.dart';

class CategoryPickerController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _uiState.value = UiState.loading;
    categories.bindStream(streamCategories());
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  RxList<CategoryModel> categories = RxList<CategoryModel>();

  Stream<List<CategoryModel>> streamCategories() {
    return _firestoreService.streamCategoriesList().map((event) {
      _uiState.value = UiState.success;
      List<CategoryModel> _categories = [];
      for (var element in event.docs) {
        _categories.add(CategoryModel.fromJson(element.data()));
      }
      notifyChildrens();
      return _categories;
    });
  }

  Future<void> onTapCategory(CategoryModel category) async {
    Get.back(result: category);
  }
}
