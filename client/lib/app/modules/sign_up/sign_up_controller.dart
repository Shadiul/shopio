import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/models/user_model.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class SignUpController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Rx<UiState> state = Rx(UiState.IDLE);

  @override
  void onInit() {
    super.onInit();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      return 'Invalid email';
    }
  }

  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please create a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
  }

  Future<void> onTapSignUp() async {
    state.value = UiState.LOADING;

    bool? isValid = formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final response = await _authService.signUp(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response is UserModel) {
        state.value = UiState.SUCCESS;
        await Get.offNamed(Routes.HOME);
      } else {
        log(response.toString());
        state.value = UiState.ERROR;

        await Get.defaultDialog(title: 'Error!', middleText: (response as FirebaseAuthException).message!);
      }
    } else {
      state.value = UiState.IDLE;
    }
  }

  Future<void> onTapAlreadyHaveAnAccount() async {
    await Get.offNamed(Routes.SIGN_IN);
  }
}
