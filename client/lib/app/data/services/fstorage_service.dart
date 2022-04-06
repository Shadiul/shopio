import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class FirebaseStorageService extends GetxService {
  final FirebaseStorage firebaseStorage;
  FirebaseStorageService(this.firebaseStorage);
  Future<FirebaseStorageService> init() async {
    return this;
  }

  Future<String> uploadImageForSearch(File _photo) async {
    final storageRef = firebaseStorage.ref();
    final searchRef = storageRef.child("search");

    await searchRef.putFile(_photo);
    return await searchRef.getDownloadURL();
  }
}
