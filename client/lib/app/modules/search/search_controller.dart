import 'dart:developer';
import 'dart:io';

import 'package:client/app/data/enums.dart';
import 'package:client/app/data/services/api_service.dart';
import 'package:client/app/data/services/fstorage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SearchController extends GetxController {
  final FirebaseStorageService _firestoreService =
      Get.find<FirebaseStorageService>();

  final ApiService _apiService = Get.find<ApiService>();

  final RxBool _isImageLoading = RxBool(false);
  bool get isImageLoading => _isImageLoading.value;

  final searchController = TextEditingController();

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
      final url = await _firestoreService.uploadImageForSearch(file);
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
