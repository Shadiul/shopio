import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/enums.dart';
import '../../../data/models/models.dart';
import '../../../data/models/product_model.dart';
import '../../../data/services/firestore_service.dart';
import 'category_picker/category_picker_view.dart';

class ProductEditorController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final Rxn<ProductModel> _product = Rxn<ProductModel>();
  ProductModel? get product => _product.value;

  RxBool isNewMode = RxBool(true);

  @override
  void onInit() {
    if (Get.arguments is ProductModel) {
      _product.value = Get.arguments;
      isNewMode.value = false;
      print('edit mode');

      nameController.text = product!.name;
      descriptionController.text = product!.description;
      categoryController.text = product!.categoryId ?? '';
      unitController.text = product!.unit;
      priceController.text = product!.price.toString();
      discountController.text = product!.discount.toString();
      stockController.text = product!.stockQuantity.toString();
      images.value = product!.images;
    }
    super.onInit();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is Required';
    }
  }

  TextEditingController descriptionController = TextEditingController();
  String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is Required';
    }
  }

  TextEditingController categoryController = TextEditingController();
  String? categoryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Category is Required';
    }
  }

  TextEditingController unitController = TextEditingController();
  String? unitValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Unit is Required';
    }
  }

  TextEditingController priceController = TextEditingController(text: '0');
  String? priceValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is Required';
    }
  }

  TextEditingController discountController = TextEditingController(text: '0');
  String? discountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Discount is Required';
    }
  }

  TextEditingController stockController = TextEditingController(text: '0');
  String? stockValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Stock is Required';
    }
  }

  final RxList<String> images = RxList<String>();

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

  Future<void> onTapCategory() async {
    final result = await Get.dialog(CategoryPickerView());
    if (result is CategoryModel) {
      categoryController.text = result.id;
    }
  }

  bool validate() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> onTapCreate() async {
    if (validate()) {
      _uiState.value = UiState.loading;
      ResponseModel response = await _firestoreService.createProduct(
        name: nameController.text,
        description: descriptionController.text,
        categoryId: categoryController.text,
        unit: unitController.text,
        price: double.parse(priceController.text),
        discount: int.parse(discountController.text),
        stockQuantity: int.parse(stockController.text),
        images: images,
      );
      if (response.status == ResponseStatus.success) {
        _uiState.value = UiState.success;
        Get.back(result: response.data);
      } else {
        _uiState.value = UiState.error;
        Get.snackbar('error', response.message);
      }
    }
  }

  Future<void> onTapUpdate() async {
    if (validate()) {
      _uiState.value = UiState.loading;
      ResponseModel response = await _firestoreService.updateProduct(
        id: product!.id,
        name: nameController.text,
        description: descriptionController.text,
        categoryId: categoryController.text,
        unit: unitController.text,
        price: double.parse(priceController.text),
        discount: int.parse(discountController.text),
        stockQuantity: int.parse(stockController.text),
        images: images,
      );
      if (response.status == ResponseStatus.success) {
        _uiState.value = UiState.success;
        Get.back(result: response.data);
      } else {
        _uiState.value = UiState.error;
        Get.snackbar('error', response.message);
      }
    }
  }
}
