import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/common/domain/use_case.dart';
import 'package:fire_hex_bloc/user/domain/parameters/registration_parameters.dart';
import 'package:fire_hex_bloc/user/domain/repositories/user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/repository/firebase_user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/services/firebase_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../../mock/authentication_repository_mock.dart';

void main() {
  group('Registration Use Case', () {
    GetIt.instance.registerSingleton<firebase.FirebaseAuth>(
      MockFirebaseAuth(
        mockUser: MockUser(
          isAnonymous: false,
          email: validEmail,
          displayName: validEmail,
        ),
      ),
    );
    GetIt.instance.registerSingleton<FirebaseFirestore>(
      FakeFirebaseFirestore(),
    );
    GetIt.instance.registerSingleton<AuthenticationService>(
      FirebaseAuthenticationService(),
    );
    GetIt.instance.registerSingleton<UserRepository>(
      FirebaseUserRepository(),
    );
    final useCase = RegistrationUseCase();
    test('Should be a subclass of UseCase', () async {
      expect(useCase, isA<UseCase>());
    });
    test('Successful Registration', () async {
      var register = await useCase.call(RegistrationParameters(
          name: validName,
          email: validEmail,
          password: validPassword,
          confirmPassword: validPassword));
      expect(register, isA<Right>());
      register.fold(
        (l) => expect(false, isTrue),
        (r) => expect(r, isA<User>()),
      );
    });
    test('Invalid email', () async {
      var register = await useCase.call(RegistrationParameters(
          name: validName,
          email: invalidEmail,
          password: validPassword,
          confirmPassword: validPassword));
      expect(register, isA<Left>());
      register.fold(
        (l) => expect(l, isA<InvalidEmail>()),
        (r) => expect(false, isTrue),
      );
    });
    test('Password too short', () async {
      var register = await useCase.call(RegistrationParameters(
          name: validName,
          email: validEmail,
          password: invalidPassword,
          confirmPassword: invalidPassword));
      expect(register, isA<Left>());
      register.fold(
        (l) => expect(l, isA<PasswordTooShort>()),
        (r) => expect(false, isTrue),
      );
    });
    test('Password does not match', () async {
      var register = await useCase.call(RegistrationParameters(
          name: validName,
          email: validEmail,
          password: validPassword,
          confirmPassword: invalidPassword));
      expect(register, isA<Left>());
      register.fold(
        (l) => expect(l, isA<PasswordDoesNotMatch>()),
        (r) => expect(false, isTrue),
      );
    });
  });
}
