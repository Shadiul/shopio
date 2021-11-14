import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/enums.dart';
import 'sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    ThemeData _themeData = Theme.of(context);
    TextTheme _textTheme = _themeData.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-In'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
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
                decoration: InputDecoration(
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
                  await controller.onTapSignIn();
                },
                decoration: InputDecoration(
                  label: Text('Password'),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: controller.state.value == UiState.LOADING ? () {} : controller.onTapSignIn,
                    child: controller.state.value == UiState.LOADING
                        ? SizedBox(
                            height: 24.0,
                            width: 24.0,
                            child: CircularProgressIndicator(
                              color: _themeData.colorScheme.onPrimary,
                            ),
                          )
                        : Text('sign-in'.toUpperCase()),
                  ),
                  TextButton(
                    onPressed: controller.onTapCreateAnAccount,
                    child: Text('Create and Account'.toUpperCase()),
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
