import 'package:admin/app/data/enums.dart';
import 'package:admin/app/data/models/category_model.dart';
import 'package:admin/app/data/models/models.dart';
import 'package:admin/app/data/services/firestore_service.dart';
import 'package:admin/app/modules/category_manager/category_editor/icon_picker/icon_picker_view.dart';
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

      _icon.value = category!.icon;
      nameController.text = category!.name;
      productsCountController.text = category!.productsCount.toString();
    }
    super.onInit();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RxString _icon = RxString(
      'https://firebasestorage.googleapis.com/v0/b/shopio-031.appspot.com/o/icons%2Fcategory_icons%2Fcategory_default.png?alt=media&token=11f15310-58df-4ccb-a6d5-a447ce92acf9');
  String get icon => _icon.value;

  TextEditingController nameController = TextEditingController();
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is Required';
    }
  }

  TextEditingController productsCountController =
      TextEditingController(text: '0');

  Future<void> onTapIconPicker() async {
    final result = await Get.dialog(IconPickerView());
    if (result is String) {
      _icon.value = result;
    }
  }

  final Rx<UiState> _uiState = Rx<UiState>(UiState.idle);
  UiState get uiState => _uiState.value;

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
      ResponseModel response = await _firestoreService.createCategory(
        name: nameController.text,
        productsCount: int.parse(productsCountController.text),
        icon: icon,
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
      ResponseModel response = await _firestoreService.updateCategory(
        id: category!.id,
        name: nameController.text,
        productsCount: int.parse(productsCountController.text),
        icon: icon,
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
