import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-Up'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                label: Text('Email'),
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                label: Text('Password'),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: controller.onTapSignUp,
                  child: Text('sign-up'.toUpperCase()),
                ),
                TextButton(
                  onPressed: controller.onTapAlreadyHaveAnAccount,
                  child: Text('Already have an account?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
