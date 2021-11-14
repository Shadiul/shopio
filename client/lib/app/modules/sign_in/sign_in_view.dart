import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-In'),
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
                  onPressed: controller.onTapSignIn,
                  child: Text('sign-in'.toUpperCase()),
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
    );
  }
}
