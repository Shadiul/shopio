import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/core/values/strings.dart';
import '../../../../data/enums.dart';
import '../../../../data/models/models.dart';
import '../../../../data/services/services.dart';

class CategoryFormController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.validationMessages.emptyCategoryName;
    }
  }

  Future<void> onTapCreate() async {
    if (formKey.currentState!.validate()) {
      ResponseModel response = await _firestoreService.createCategory(
        {
          'id': '',
          'name': nameController.text,
          'icon': 'category_beauty',
        },
      );
      if (response.status == ResponseStatus.success) {
        Get.back(result: response.data);
      }
    }
  }
}
