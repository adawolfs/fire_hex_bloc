// Test Form Widget

import 'package:fire_hex_bloc/user/application/bloc/registration/registration_bloc.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/user/infrastructure/ui/pages/registration_page.dart';
import 'package:fire_hex_bloc/user/infrastructure/ui/widgets/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../mock/authentication_repository_mock.dart';

main() {
  group("Registration Page", () {
    GetIt.instance.registerSingleton<AuthenticationService>(
      AutheticationRepositoryMock(),
    );
    GetIt.instance
        .registerSingleton<RegistrationUseCase>(RegistrationUseCase());
    testWidgets("should implement form, textfields and button",
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => RegistrationBloc(),
        child: const MaterialApp(
          home: Scaffold(
            body: RegistrationPage(),
          ),
        ),
      ));
      await tester.pumpAndSettle();
      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text("Name"), findsOneWidget);
      expect(find.text("Email"), findsOneWidget);
      expect(find.text("Register"), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets("should success on register", (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider(
        create: (context) => RegistrationBloc(),
        child: MaterialApp(
          home: Scaffold(
            body: RegistrationForm(),
          ),
        ),
      ));
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
      expect(find.text("Success"), findsOneWidget);
    });
  });
}
