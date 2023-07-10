import 'package:fire_hex_bloc/authentication/application/parameters/user_registration_parameters.dart';
import 'package:fire_hex_bloc/authentication/domain/entities/user.dart';
import 'package:fire_hex_bloc/authentication/domain/failures/registration_failure.dart';
import 'package:fire_hex_bloc/authentication/domain/repositories/authentication_repository.dart';
import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/common/domain/use_case.dart';
import 'package:fpdart/fpdart.dart';

class UserRegistration implements UseCase<User, UserRegistrationParameters> {
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  AuthenticationRepository authenticationRepository;
  UserRegistration(this.authenticationRepository);

  @override
  Future<Either<Failure, User>> call(UserRegistrationParameters parameters) {
    if (parameters.email.isEmpty) {
      return Future.value(Left(InvalidEmailFailure()));
    }

    if (parameters.password.isEmpty) {
      return Future.value(Left(InvalidPasswordFailure()));
    }

    if (parameters.password != parameters.passwordConfirmation) {
      return Future.value(Left(InvalidPasswordFailure()));
    }

    if (!emailRegex.hasMatch(parameters.email)) {
      return Future.value(Left(InvalidEmailFailure()));
    }

    return authenticationRepository
        .register(User(email: parameters.email, password: parameters.password));
  }
}
