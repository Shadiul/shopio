import 'package:admin/app/data/enums.dart';
import 'package:admin/app/data/models/product_model.dart';
import 'package:admin/app/data/services/services.dart';
import 'package:get/get.dart';

class ProductManagerController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  @override
  void onInit() {
    _uiState.value = UiState.loading;
    products.bindStream(streamProducts());
    super.onInit();
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  RxList<ProductModel> products = RxList<ProductModel>();
  RxList<String> categoryIcons = RxList<String>();

  Stream<List<ProductModel>> streamProducts() {
    return _firestoreService.streamProductsList().map((event) {
      print(event.docs);
      _uiState.value = UiState.success;
      List<ProductModel> _products = [];
      for (var element in event.docs) {
        _products.add(ProductModel.fromJson(element.data()));
      }
      return _products;
    });
  }
}
