import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../utils/log_colored.dart';
import 'auth_service.dart';

export 'auth_service.dart';

Future<void> initServices() async {
  logColored('📦 Starting services', color: LogColor.white);
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Get.putAsync(
    () => AuthService(_firebaseAuth, _firebaseFirestore).init(),
  );
  logColored('✔️ All Service Started', color: LogColor.white);
}
