import 'package:get/get.dart';

import '../../../../data/enums.dart';
import '../../../../data/models/product_model.dart';
import '../../../../data/services/services.dart';
import '../../product_editor/product_editor_view.dart';

class ProductsDataTableController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _uiState.value = UiState.loading;
    products.bindStream(streamProducts());
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  RxList<ProductModel> products = RxList();

  Stream<List<ProductModel>> streamProducts() {
    return _firestoreService.streamProductsList().map((event) {
      List<ProductModel> _products = [];
      for (var element in event.docs) {
        _products.add(ProductModel.fromJson(element.data()));
      }
      _uiState.value = UiState.success;
      return _products;
    });
  }

  Future<void> onTapAddProduct() async {
    await Get.dialog(
      ProductEditorView(),
    );
  }

  Future<void> onTapEditProduct(int index) async {
    await Get.dialog(ProductEditorView(), arguments: products[index]);
  }

  RxInt sortColumnIndex = RxInt(0);
  RxBool sortAscending = RxBool(false);

  Future<void> deleteItem(index) async {
    ProductModel product = products[index];
    await _firestoreService.deleteProduct(product.id);
  }
}
