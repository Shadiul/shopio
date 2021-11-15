import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/core/values/strings.dart';
import '../../data/enums.dart';
import '../../data/models/response_model.dart';
import '../../data/services/services.dart';
import '../../routes/app_pages.dart';

class SignInController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Rx<UiState> state = Rx(UiState.idle);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.validationMessages.emptyEmail;
    } else if (!GetUtils.isEmail(value)) {
      return Strings.validationMessages.invalidEmail;
    }
  }

  TextEditingController passwordController = TextEditingController();
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.validationMessages.emptyPassword;
    } else if (value.length < 6) {
      return Strings.validationMessages.shortPassword;
    }
  }

  Future<void> onTapSignIn() async {
    state.value = UiState.loading;

    bool? isValid = formKey.currentState?.validate();

    if (isValid != null && isValid) {
      final ResponseModel response = await _authService.signIn(
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
        return;
      }
    }
    state.value = UiState.idle;
  }

  Future<void> onTapCreateAnAccount() async {
    await Get.offNamed(Routes.SIGN_UP);
  }
}
