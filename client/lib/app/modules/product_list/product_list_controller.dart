import 'package:get/get.dart';

import '../../data/models/models.dart';
import '../../data/services/services.dart';

class ProductListController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _categoryId = Get.parameters['category_id'];
    _category.value = Get.arguments as CategoryModel?;
    products.bindStream(stramProducts());
    super.onInit();
  }

  String? _categoryId;
  final Rxn<CategoryModel> _category = Rxn<CategoryModel>();
  CategoryModel? get category => _category.value;

  RxList<ProductModel> products = RxList<ProductModel>();

  Stream<List<ProductModel>> stramProducts() {
    return _firestoreService
        .streamProducts(categoryId: _categoryId)
        .map((event) {
      List<ProductModel> _products = [];
      for (var element in event.docs) {
        _products.add(ProductModel.fromJson(element.data()));
      }
      return _products;
    });
  }
}
