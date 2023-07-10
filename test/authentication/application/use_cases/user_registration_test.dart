import 'package:fire_hex_bloc/authentication/application/parameters/user_registration_parameters.dart';
import 'package:fire_hex_bloc/authentication/application/use_cases/user_registration.dart';
import 'package:fire_hex_bloc/authentication/domain/entities/user.dart';
import 'package:fire_hex_bloc/authentication/domain/failures/registration_failure.dart';
import 'package:fire_hex_bloc/authentication/domain/repositories/authentication_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
import 'user_registration_test.mocks.dart';

String validEmail = 'valide@email.com';
String validPassword = 'validPassword';
String invalidEmail = 'invalidEmail';
String invalidPassword = 'invalidPassword';
String invalidPasswordConfirmation = 'invalidPasswordConfirmation';

void main() {
  group('Registration Use Case', () {
    late MockAuthenticationRepository mockUserRepository;
    setUp(() {
      mockUserRepository = MockAuthenticationRepository();
    });
    test('Successful Registration', () async {
      User validUser = User(email: validEmail, password: validPassword);
      when(mockUserRepository.register(validUser))
          .thenAnswer((user) async => Right(validUser));
      var userRegistration = UserRegistration(mockUserRepository);
      var registrationResult = await userRegistration.call(
          UserRegistrationParameters(
              email: validEmail,
              password: validPassword,
              passwordConfirmation: validPassword));
      expect(registrationResult.isRight(), true);
    });
    test('Failed Registration - Email Already in Use', () async {
      User invalidUser = User(email: validEmail, password: validPassword);
      when(mockUserRepository.register(invalidUser))
          .thenAnswer((user) async => Left(EmailAlreadyInUseFailure()));
      var userRegistration = UserRegistration(mockUserRepository);
      var registrationResult = await userRegistration.call(
          UserRegistrationParameters(
              email: validEmail,
              password: validPassword,
              passwordConfirmation: validPassword));
      expect(registrationResult.isLeft(), true);
      registrationResult.fold(
          (l) => expect(l is EmailAlreadyInUseFailure, true),
          (r) => expect(true, false));
    });
    test('Failed Registration - Passwords Do Not Match', () async {
      User invalidUser = User(email: validEmail, password: validPassword);
      when(mockUserRepository.register(invalidUser))
          .thenAnswer((user) async => Right(invalidUser));
      var userRegistration = UserRegistration(mockUserRepository);
      var registrationResult = await userRegistration.call(
          UserRegistrationParameters(
              email: validEmail,
              password: validPassword,
              passwordConfirmation: invalidPassword));
      expect(registrationResult.isLeft(), true);
      registrationResult.fold((l) => expect(l is InvalidPasswordFailure, true),
          (r) => expect(true, false));
    });
    test('Failed Registration - Invalid Email', () async {
      User invalidUser = User(email: validEmail, password: validPassword);
      when(mockUserRepository.register(invalidUser))
          .thenAnswer((user) async => Left(RegistrationFailure()));
      var userRegistration = UserRegistration(mockUserRepository);
      var registrationResult = await userRegistration.call(
          UserRegistrationParameters(
              email: invalidEmail,
              password: validPassword,
              passwordConfirmation: validPassword));
      expect(registrationResult.isLeft(), true);
      registrationResult.fold((l) => expect(l is InvalidEmailFailure, true),
          (r) => expect(true, false));
    });
  });
}
