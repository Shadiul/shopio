import 'package:client/app/data/models/models.dart';
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
    super.onReady();
  }

  RxList<CategoryModel> categories = RxList<CategoryModel>();

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

  Future<List<ProductModel>> getBestSellerProducts() async {
    final response = await _firestoreService.getBestSellerProducts();
    if (response.status == ResponseStatus.success) {
      return response.data!;
    } else {
      return [];
    }
  }

  Future<void> onTapProduct(ProductModel product) async {
    await Get.toNamed(
      Routes.PRODUCT_DETAILS,
      parameters: {'id': product.id},
      arguments: product,
    );
  }
}
