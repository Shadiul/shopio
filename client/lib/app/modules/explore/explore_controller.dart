import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/models/category_model.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class ExploreController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  Rx<UiState> categoriesState = Rx(UiState.idle);

  @override
  Future<void> onReady() async {
    categories.bindStream(streamCategoriesList());
    // await getCategories();
    super.onReady();
  }

  RxList<CategoryModel> categories = RxList<CategoryModel>();
  // Future<void> getCategories() async {
  //   categoriesState.value = UiState.loading;
  // logColored('📦 Loading fake categories from asset', color: LogColor.white);

  // try {
  //   final categoryBundleData = await rootBundle.loadString(
  //     'assets/json/fake_categories.json',
  //   );
  //   final jsonData = jsonDecode(categoryBundleData);
  //   categories.value = List.from((jsonData['data'] as List).map(
  //     (e) => CategoryModel.fromJson(e),
  //   ));
  //   logColored(
  //     '📦 Success loading fake categories from asset',
  //     color: LogColor.green,
  //   );
  // } catch (e) {
  //   log(e.toString());
  //   categoriesState.value = UiState.error;
  //   return;
  // }

  //   categoriesState.value = UiState.success;
  // }

  Stream<List<CategoryModel>> streamCategoriesList({String? categoryId}) {
    return _firestoreService.streamCategoriesList().map((event) {
      List<CategoryModel> _categories = [];
      for (var element in event.docs) {
        _categories.add(CategoryModel.fromJson(element.data()));
      }
      return _categories;
    });
  }

  Future<void> onTapCategory(CategoryModel category) async {
    await Get.toNamed(
      Routes.PRODUCT_LIST,
      parameters: {'category_id': category.id},
      arguments: category,
    );
  }
}
