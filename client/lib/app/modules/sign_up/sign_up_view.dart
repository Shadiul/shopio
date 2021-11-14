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
      body: Center(
        child: Text(
          'SignUpView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
