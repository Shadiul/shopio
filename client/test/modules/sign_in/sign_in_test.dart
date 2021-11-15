import 'package:client/app/data/core/values/strings.dart';
import 'package:client/app/data/enums.dart';
import 'package:client/app/data/models/user_model.dart';
import 'package:client/app/data/services/services.dart';
import 'package:client/app/modules/sign_in/sign_in_controller.dart';
import 'package:client/app/modules/sign_in/sign_in_view.dart';
import 'package:client/app/routes/app_pages.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

UserModel user = UserModel(
  uid: 'abcd1234',
  name: 'Mock User',
  email: 'mock@email.com',
);

void main() {
  GetMaterialApp widget = GetMaterialApp(
    initialRoute: Routes.SIGN_IN,
    getPages: AppPages.routes,
  );
  group('Login test', () {
    setUp(() async {
      final firebaseFirestore = FakeFirebaseFirestore();
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());
      await Get.putAsync(
        () => AuthService(
          MockFirebaseAuth(
            signedIn: false,
            mockUser: MockUser(uid: user.uid, email: user.email),
          ),
          firebaseFirestore,
        ).init(),
      );
    });

    testWidgets('with valid form', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(SignInView), findsOneWidget);

      SignInController controller = Get.find<SignInController>();

      expect(controller.state.value, UiState.idle);
      expect(controller.emailController.text, isEmpty);
      expect(controller.passwordController.text, isEmpty);

      controller.emailController.text = user.email;
      controller.passwordController.text = '123456';

      bool? isValid = controller.formKey.currentState?.validate();
      expect(isValid, true);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(controller.state.value, UiState.success);
    });
    testWidgets('without valid form', (WidgetTester tester) async {
      await tester.pumpWidget(widget);
      expect(find.byType(SignInView), findsOneWidget);

      SignInController controller = Get.find<SignInController>();
      // controller.emailController.text = '';
      // controller.passwordController.text = '';

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(controller.state.value, UiState.idle);
      expect(controller.emailController.text, isEmpty);
      expect(controller.passwordController.text, isEmpty);

      bool? isValid = controller.formKey.currentState?.validate();
      expect(isValid, false);

      final emptyEmail = find.text(Strings.validationMessages.emptyEmail);
      expect(emptyEmail, findsOneWidget);

      final emptyPassword = find.text(Strings.validationMessages.emptyPassword);
      expect(emptyPassword, findsOneWidget);

      controller.emailController.text = 'an invalid email';
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      final invalidEmail = find.text(Strings.validationMessages.invalidEmail);
      expect(invalidEmail, findsOneWidget);

      controller.passwordController.text = '123';
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      final shortPassword = find.text(Strings.validationMessages.shortPassword);
      expect(shortPassword, findsOneWidget);
    });
  });
}
