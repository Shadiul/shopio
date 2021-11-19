import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/log_colored.dart';
import 'auth_service.dart';
import 'firestore_service.dart';

export 'auth_service.dart';
export 'firestore_service.dart';

Future<void> initServices() async {
  logColored('📦 Starting services', color: LogColor.white);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  await Get.putAsync(
    () => AuthService(_firebaseAuth, _firebaseFirestore).init(),
  );
  await Get.putAsync(
    () => FirestoreService(_firebaseFirestore).init(),
  );
  logColored('✔️ All Service Started', color: LogColor.white);
}
