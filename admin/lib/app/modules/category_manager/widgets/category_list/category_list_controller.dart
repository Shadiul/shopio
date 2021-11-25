import 'package:get/get.dart';

import '../../../../data/enums.dart';
import '../../../../data/models/models.dart';
import '../../../../data/services/services.dart';

class CategoryListController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _uiState.value = UiState.loading;
    categories.bindStream(stramCategories());
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  RxList<CategoryModel> categories = RxList<CategoryModel>();

  Stream<List<CategoryModel>> stramCategories() {
    return _firestoreService.streamCategoriesList().map((event) {
      _uiState.value = UiState.success;
      List<CategoryModel> _categories = [];
      for (var element in event.docs) {
        _categories.add(CategoryModel.fromJson(element.data()));
      }
      return _categories;
    });
  }

  RxInt sortColumnIndex = RxInt(0);
  RxBool sortAscending = RxBool(false);
}
