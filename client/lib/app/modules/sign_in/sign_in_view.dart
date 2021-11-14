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
      body: Center(
        child: Text(
          'SignInView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
