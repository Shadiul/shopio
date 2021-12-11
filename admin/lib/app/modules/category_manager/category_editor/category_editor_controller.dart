import 'package:admin/app/data/enums.dart';
import 'package:admin/app/data/models/category_model.dart';
import 'package:admin/app/data/models/models.dart';
import 'package:admin/app/data/services/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CategoryEditorController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final Rxn<CategoryModel> _category = Rxn<CategoryModel>();
  CategoryModel? get category => _category.value;

  RxBool isNewMode = RxBool(true);

  @override
  void onInit() {
    if (Get.arguments is CategoryModel) {
      _category.value = Get.arguments;
      isNewMode.value = false;
      print('edit mode');

      nameController.text = category!.name;
      productsCountController.text = category!.productsCount.toString();
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

  TextEditingController productsCountController =
      TextEditingController(text: '0');

  Future<void> onTapCreate() async {
    if (formKey.currentState!.validate()) {
      ResponseModel response = await _firestoreService.createCategory(
        name: nameController.text,
        productsCount: int.parse(productsCountController.text),
      );
      if (response.status == ResponseStatus.success) {
        Get.back(result: response.data);
      } else {
        Get.snackbar('error', response.message);
      }
    }
  }

  Future<void> onTapUpdate() async {
    if (formKey.currentState!.validate()) {
      ResponseModel response = await _firestoreService.updateCategory(
        id: category!.id,
        name: nameController.text,
        productsCount: int.parse(productsCountController.text),
      );
      if (response.status == ResponseStatus.success) {
        Get.back(result: response.data);
      } else {
        Get.snackbar('error', response.message);
      }
    }
  }
}
