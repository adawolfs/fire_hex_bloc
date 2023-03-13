// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/user/domain/repositories/user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/repository/firebase_user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/services/firebase_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fire_hex_bloc/main.dart';
import 'package:get_it/get_it.dart';

import 'mock/authentication_repository_mock.dart';

void main() {
  group('Application', () {
    setUp(() {
      GetIt.instance.registerSingleton<FirebaseAuth>(MockFirebaseAuth());
      GetIt.instance
          .registerSingleton<FirebaseFirestore>(FakeFirebaseFirestore());
      GetIt.instance.registerSingleton<UserRepository>(
        FirebaseUserRepository(),
      );
      GetIt.instance.registerSingleton<AuthenticationService>(
          FirebaseAuthenticationService());
      GetIt.instance
          .registerSingleton<RegistrationUseCase>(RegistrationUseCase());
    });
    tearDown(() {
      GetIt.instance.unregister(instance: GetIt.instance<FirebaseAuth>());
      GetIt.instance.unregister(instance: GetIt.instance<FirebaseFirestore>());
      GetIt.instance.unregister(instance: GetIt.instance<UserRepository>());
      GetIt.instance
          .unregister(instance: GetIt.instance<AuthenticationService>());
      GetIt.instance
          .unregister(instance: GetIt.instance<RegistrationUseCase>());
    });
    testWidgets('Smoke test', (WidgetTester tester) async {
      await tester.pumpWidget(const Application());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('Application')), findsOneWidget);
    });
    testWidgets('Registration', (WidgetTester tester) async {
      await tester.pumpWidget(const Application());
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key("registerForm_nameInput_textField")), validName);
      await tester.enterText(
          find.byKey(const Key("registerForm_emailInput_textField")),
          validEmail);
      await tester.enterText(
          find.byKey(const Key("registerForm_passwordInput_textField")),
          validPassword);
      await tester.enterText(
          find.byKey(const Key("registerForm_confirmPasswordInput_textField")),
          validPassword);
      await tester
          .tap(find.byKey(const Key("registerForm_register_elevatedButton")));
      await tester.pumpAndSettle();
      expect(find.text("Home Page"), findsOneWidget);
    });
  });
}
