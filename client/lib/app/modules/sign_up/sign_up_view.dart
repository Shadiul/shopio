import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/enums.dart';
import 'sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    // TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-Up'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.emailController,
                validator: controller.emailValidator,
                keyboardType: TextInputType.emailAddress,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                decoration: const InputDecoration(
                  label: Text('Email'),
                ),
              ),
              TextFormField(
                controller: controller.passwordController,
                validator: controller.passwordValidator,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                onFieldSubmitted: (value) async {
                  FocusScope.of(context).unfocus();
                  await controller.onTapSignUp();
                },
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => ElevatedButton(
                        onPressed: controller.state.value == UiState.loading
                            ? () {}
                            : controller.onTapSignUp,
                        child: controller.state.value == UiState.loading
                            ? SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: CircularProgressIndicator(
                                  color: _themeData.colorScheme.onPrimary,
                                ),
                              )
                            : Text('sign-up'.toUpperCase()),
                      )),
                  TextButton(
                    onPressed: controller.onTapAlreadyHaveAnAccount,
                    child: const Text('Already have an account?'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
