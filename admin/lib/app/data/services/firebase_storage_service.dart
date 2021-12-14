import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../enums.dart';
import '../models/response_model.dart';

class FirebaseStorageService extends GetxService {
  Future<FirebaseStorageService> init() async {
    return this;
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<ResponseModel> getDownloadUrl(String fileName) async {
    try {
      String url = await _storage
          .refFromURL('gs://shopio-031.appspot.com/')
          .child(fileName)
          .getDownloadURL();
      return ResponseModel(
        status: ResponseStatus.success,
        message: 'Success fetching URL: $url',
        data: url,
      );
    } catch (e) {
      return ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
  }
}
