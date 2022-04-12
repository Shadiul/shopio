import 'dart:developer';
import 'dart:io';

import 'package:client/app/data/enums.dart';
import 'package:client/app/data/models/models.dart';
import 'package:client/app/data/services/api_service.dart';
import 'package:client/app/data/services/firestore_service.dart';
import 'package:client/app/data/services/fstorage_service.dart';
import 'package:client/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SearchController extends GetxController
    with StateMixin<List<ProductModel>> {
  final FirebaseStorageService _firebaseStorageService =
      Get.find<FirebaseStorageService>();
  final FirestoreService _firestoreService = Get.find<FirestoreService>();

  final ApiService _apiService = Get.find<ApiService>();

  final RxBool _isImageLoading = RxBool(false);
  bool get isImageLoading => _isImageLoading.value;

  final RxBool _hasQuery = RxBool(false);
  bool get hasQuery => _hasQuery.value;

  final searchController = TextEditingController();
  RxList<ProductModel> products = RxList<ProductModel>();

  @override
  void onInit() {
    searchController.addListener(() {
      _hasQuery.value = searchController.text.isNotEmpty;
      searchProducts();
    });
    super.onInit();
  }

  Future<void> onTapCamera() async {
    searchController.clear();

    final ImagePicker _picker = ImagePicker();
    final XFile? _photo =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (_photo != null) {
      _isImageLoading.value = true;
      log('✔️ Image picked');

      File file = File(_photo.path);

      log('✔️ Trying to Upload');
      final url = await _firebaseStorageService.uploadImageForSearch(file);
      log('✔️ URL found,\nURL: $url');

      log('✔️ Searching for tags');
      final response = await _apiService.searchForTags(url);

      if (response.status == ResponseStatus.success) {
        List<dynamic> tagsListMap = response.data['result']['tags'];

        List<String> tags =
            List<String>.from(tagsListMap.map((e) => e['tag']['en'])).toList();

        log(tags.toString());
        searchController.text = tags.first;
      }
    }

    _isImageLoading.value = false;
  }

  Future<void> searchProducts() async {
    change([], status: RxStatus.loading());
    final response =
        await _firestoreService.searchProducts(searchController.text);

    if (response.status == ResponseStatus.success) {
      change(
        response.data,
        status: response.data!.isEmpty ? RxStatus.empty() : RxStatus.success(),
      );
    } else {
      change([], status: RxStatus.error());
    }
  }

  Future<void> onTapProduct(ProductModel product) async {
    await Get.toNamed(
      Routes.PRODUCT_DETAILS,
      parameters: {'id': product.id},
      arguments: product,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
