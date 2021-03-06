import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/enums.dart';
import '../../data/models/response_model.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class SignUpController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Rx<UiState> state = Rx(UiState.idle);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    } else if (value.length < 6) {
      return 'Name should be at least 6 characters long';
    }
  }

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
    state.value = UiState.loading;

    bool? isValid = formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final ResponseModel response = await _authService.signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.status == ResponseStatus.success) {
        state.value = UiState.success;
        await Get.offNamed(Routes.HOME);
      } else {
        state.value = UiState.error;
        await Get.defaultDialog(
          title: 'Error!',
          middleText: response.message,
        );
      }
    }
    state.value = UiState.idle;
  }

  Future<void> onTapAlreadyHaveAnAccount() async {
    await Get.offNamed(Routes.SIGN_IN);
  }
}
