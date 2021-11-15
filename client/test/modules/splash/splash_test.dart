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
  group('splash test works', () {
    setUp(() async {});
    testWidgets('without signed-in user', (WidgetTester tester) async {
      await Get.putAsync(
        () => AuthService(
          MockFirebaseAuth(signedIn: false, mockUser: null),
          FakeFirebaseFirestore(),
        ).init(),
      );
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ),
      );

      final titleFinder = find.text('Shopio');
      expect(titleFinder, findsOneWidget);
      await tester.pump(
        const Duration(seconds: 5),
      );
      expect(find.byType(SignInView), findsOneWidget);
    });

    testWidgets('with signed-in user works', (WidgetTester tester) async {
      final firebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: user.uid,
          email: user.email,
        ),
      );
      final firebaseFirestore = FakeFirebaseFirestore();
      await firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(user.toJson());

      await Get.putAsync(
        () async => await AuthService(
          firebaseAuth,
          firebaseFirestore,
        ).init(),
      );

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        ),
      );
      await tester.pump(
        const Duration(seconds: 5),
      );

      // expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
