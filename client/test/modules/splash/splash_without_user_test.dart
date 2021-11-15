import 'package:client/app/data/models/user_model.dart';
import 'package:client/app/data/services/services.dart';
import 'package:client/app/modules/sign_in/sign_in_view.dart';
import 'package:client/app/routes/app_pages.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

UserModel user = UserModel(
  uid: 'abcd1234',
  name: 'Mock User',
  email: 'mock@email.com',
);
void main() {
  GetMaterialApp widget = GetMaterialApp(
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  );
  group('splash test works', () {
    testWidgets('without signed-in user', (WidgetTester tester) async {
      await Get.putAsync(
        () => AuthService(
          MockFirebaseAuth(signedIn: false, mockUser: null),
          FakeFirebaseFirestore(),
        ).init(),
      );
      await tester.pumpWidget(widget);

      await tester.pump(const Duration(seconds: 5));
      expect(find.byType(SignInView), findsOneWidget);
    });
  });
}
