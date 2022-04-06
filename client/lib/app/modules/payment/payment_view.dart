import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () => controller.onTapPaymentMethod('bKash'),
            child: const Text('bKash'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.onTapPaymentMethod('Cash'),
            child: const Text('Cash'),
          ),
        ],
      ),
    );
  }
}
