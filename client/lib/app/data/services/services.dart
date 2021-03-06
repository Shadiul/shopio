import 'package:client/app/data/services/api_service.dart';
import 'package:client/app/data/services/fstorage_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/log_colored.dart';
import 'auth_service.dart';
import 'cart_service.dart';
import 'firestore_service.dart';

export 'auth_service.dart';
export 'cart_service.dart';
export 'firestore_service.dart';

Future<void> initServices() async {
  logColored('📦 Starting services', color: LogColor.white);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  await Get.putAsync(
    () => AuthService(_firebaseAuth, _firebaseFirestore).init(),
  );
  await Get.putAsync(
    () => FirestoreService(_firebaseFirestore).init(),
  );
  await Get.putAsync(
    () => FirebaseStorageService(_firebaseStorage).init(),
  );
  await Get.putAsync(
    () => ApiService().init(),
  );
  await Get.putAsync(
    () => CartService().init(),
  );
  logColored('✔️ All Service Started', color: LogColor.white);
}
