import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../utils/log_colored.dart';
import '../enums.dart';
import '../models/response_model.dart';
import '../models/user_model.dart';

class AuthService extends GetxService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthService(this.auth, this.firestore);

  Future<AuthService> init() async {
    return this;
  }

  Logger logger = Logger();
  UserModel? _user;
  UserModel? get user => _user;

  Future<ResponseModel> tryAutoSignIn() async {
    logColored('🔍 Looking for logged in account', color: LogColor.white);
    ResponseModel response;
    if (auth.currentUser == null) {
      response = ResponseModel(
        status: ResponseStatus.empty,
        message: '⭕ No logged in user found',
      );
    } else {
      logColored(
        '😀 Found logged in user: ${auth.currentUser!.email}',
        color: LogColor.green,
      );
      response = await getUserData(auth.currentUser!.uid);
      _user = response.data;
    }
    return response;
  }

  Future<ResponseModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    ResponseModel response;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _user = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
      );

      await firestore.collection('users').doc(_user!.uid).set(_user!.toJson());
      response = ResponseModel(
        status: ResponseStatus.success,
        message: 'Sign-Up Success',
        data: _user,
      );
    } on FirebaseAuthException catch (e) {
      // String message;
      // switch (e.code) {
      //   case 'weak-password':
      //     message = 'The password provided is too weak.';
      //     break;
      //   case 'email-already-in-use':
      //     message = 'The account already exists for that email.';
      //     break;
      //   default:
      //     message = e.code;
      //     break;
      // }
      response = ResponseModel(
        status: ResponseStatus.error,
        code: e.code,
        message: e.message ?? 'No Message, Check code',
      );
    } catch (e) {
      logger.e(e);
      response = ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
    return response;
  }

  Future<ResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    ResponseModel response;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ResponseModel userDataResponse = await getUserData(
        userCredential.user!.uid,
      );
      _user = userDataResponse.data;
      response = ResponseModel(
        status: ResponseStatus.success,
        message: 'Sign in success',
      );
    } on FirebaseAuthException catch (e) {
      // String message;
      // switch (e.code) {
      //   case 'user-not-found':
      //     message = 'No user found for that email.';
      //     break;
      //   case 'wrong-password':
      //     message = 'Wrong password provided for that user.';
      //     break;
      //   default:
      //     message = e.code;
      //     break;
      // }
      response = ResponseModel(
        status: ResponseStatus.error,
        code: e.code,
        message: e.message ?? 'No Message, Check code',
      );
    } catch (e) {
      response = ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }

    return response;
  }

  Future<ResponseModel> signOut() async {
    ResponseModel response;
    try {
      await auth.signOut();
      response = ResponseModel(
        status: ResponseStatus.success,
        message: 'Signout Success',
      );
    } on FirebaseAuthException catch (e) {
      response = ResponseModel(
        status: ResponseStatus.error,
        code: e.code,
        message: e.message ?? 'No Message, Check code',
      );
    } catch (e) {
      response = ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }

    return response;
  }

  Future<ResponseModel> getUserData(String uid) async {
    ResponseModel response;
    try {
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(uid).get();
      response = ResponseModel(
        status: ResponseStatus.success,
        message: '⏬ User data fetch success',
        data: UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>),
      );
    } catch (e) {
      logger.e(e);
      response = ResponseModel(
        status: ResponseStatus.error,
        message: e.toString(),
      );
    }
    return response;
  }
}
