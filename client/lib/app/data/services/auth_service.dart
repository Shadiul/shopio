import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../models/user_model.dart';

class AuthService extends GetxService {
  Future<AuthService> init() async {
    return this;
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Logger logger = Logger();
  UserModel? _user;
  UserModel? get user => _user;

  Future<void> tryAutoSignIn() async {
    if (_auth.currentUser == null) {
    } else {
      _user = await getUserData(_auth.currentUser!.uid);
    }
  }

  Future<dynamic> signUp({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = UserModel(
        uid: userCredential.user!.uid,
        email: email,
      );

      await _firestore.collection('users').doc(_user!.uid).set(_user!.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.e('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logger.e('The account already exists for that email.');
      }
      return e;
    } catch (e) {
      logger.e(e);
      return e.toString();
    }
  }

  Future<dynamic> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = await getUserData(userCredential.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.e('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.e('Wrong password provided for that user.');
      }
      return e;
    } catch (e) {
      logger.e(e);
      return e.toString();
    }
  }

  Future<UserModel?> getUserData(String uid) async {
    try {
      DocumentSnapshot userSnapshot = await _firestore.collection('users').doc(uid).get();
      return UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      logger.e(e);
    }
  }
}
