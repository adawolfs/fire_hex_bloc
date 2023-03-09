import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/domain/repositories/registration_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

const String validEmail = 'test@mail.com';
const String validPassword = 'aA1!aA1!aA1!aA1!';
const String invalidEmail = 'invalid';
const String invalidPassword = '123456';

class RegistrationRepositoryMock extends Fake
    implements RegistrationRepository {
  @override
  Future<Either<Failure, User>> register(params) {
    if (params.email == invalidEmail) {
      return Future.value(Left(InvalidEmail()));
    }
    if (params.password != params.confirmPassword) {
      return Future.value(Left(PasswordDoesNotMatch()));
    }
    if (params.password.length < 8) {
      return Future.value(Left(PasswordTooShort()));
    }
    return Future.value(Right(User()));
  }
}
