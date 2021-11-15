import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/models/category_model.dart';
import '../../utils/log_colored.dart';

class ExploreController extends GetxController {
  Rx<UiState> categoriesState = Rx(UiState.idle);

  @override
  Future<void> onReady() async {
    await getCategories();
    super.onReady();
  }

  RxList<CategoryModel> categories = RxList<CategoryModel>();
  Future<void> getCategories() async {
    logColored('📦 Loading fake categories from asset', color: LogColor.white);
    categoriesState.value = UiState.loading;

    try {
      final categoryBundleData = await rootBundle.loadString(
        'assets/json/fake_categories.json',
      );
      final jsonData = jsonDecode(categoryBundleData);
      categories.value = List.from((jsonData['data'] as List).map(
        (e) => CategoryModel.fromJson(e),
      ));
      logColored(
        '📦 Success loading fake categories from asset',
        color: LogColor.green,
      );
    } catch (e) {
      log(e.toString());
      categoriesState.value = UiState.error;
      return;
    }

    categoriesState.value = UiState.success;
  }
}
