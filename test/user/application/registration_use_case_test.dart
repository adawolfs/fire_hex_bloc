import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/domain/repositories/registration_repository.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/common/domain/use_case.dart';
import 'package:fire_hex_bloc/user/domain/parameters/registration_parameters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../../mock/registration_repository_mock.dart';

void main() {
  group('Registration Use Case', () {
    GetIt.instance.registerSingleton<RegistrationRepository>(
      RegistrationRepositoryMock(),
    );
    // arrange
    final useCase = RegistrationUseCase();
    test('Should be a subclass of UseCase', () async {
      // assert
      expect(useCase, isA<UseCase>());
    });
    test('Successful Registration', () async {
      var register = await useCase.call(RegistrationParameters(
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
