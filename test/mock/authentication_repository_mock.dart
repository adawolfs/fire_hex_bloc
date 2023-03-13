import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

const String validName = 'Test Name';
const String validEmail = 'test@mail.com';
const String validPassword = 'aA1!aA1!aA1!aA1!';
const String invalidEmail = 'invalid';
const String invalidPassword = '123456';

class AutheticationRepositoryMock extends Fake
    implements AuthenticationService {
  @override
  Future<Either<Failure, User>> register(
      String email, String name, String password) {
    if (email == invalidEmail) {
      return Future.value(Left(InvalidEmail()));
    }
    if (password.length < 8) {
      return Future.value(Left(PasswordTooShort()));
    }
    return Future.value(Right(User(
      name: name,
      email: email,
    )));
  }
}
