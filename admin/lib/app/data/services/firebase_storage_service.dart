import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../../utils/log_colored.dart';

class FirebaseStorageService extends GetxService {
  Future<FirebaseStorageService> init() async {
    return this;
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getDownloadUrl(String fileName) async {
    try {
      String url = await _storage
          .refFromURL('gs://shopio-031.appspot.com/')
          .child(fileName)
          .getDownloadURL();
      logColored(url, color: LogColor.magenta);
      return url;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
