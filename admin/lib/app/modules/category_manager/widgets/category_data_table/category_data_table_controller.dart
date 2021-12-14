import 'package:get/get.dart';

import '../../../../data/enums.dart';
import '../../../../data/models/models.dart';
import '../../../../data/services/services.dart';
import '../../category_editor/category_editor_view.dart';

class CategoryDataTableController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _uiState.value = UiState.loading;
    categories.bindStream(streamCategories());
    categoryIcons.bindStream(streamCategoryIcons());
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  RxList<CategoryModel> categories = RxList<CategoryModel>();
  RxList<String> categoryIcons = RxList<String>();

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

  Stream<List<String>> streamCategoryIcons() {
    return _firestoreService.streamCategoryIcons().map((event) {
      List<String> _icons = [];
      for (var element in event.data()!['icons']) {
        _icons.add(element);
      }
      return _icons;
    });
  }

  Future<void> onTapAddCategory() async {
    await Get.dialog(
      CategoryEditorView(),
    );
  }

  Future<void> onTapEditCategory(int index) async {
    await Get.dialog(CategoryEditorView(), arguments: categories[index]);
  }

  RxInt sortColumnIndex = RxInt(0);
  RxBool sortAscending = RxBool(false);

  Future<void> deleteItem(index) async {
    CategoryModel category = categories[index];
    await _firestoreService.deleteCategory(category.id);
  }
}
