import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/common/domain/use_case.dart';
import 'package:fire_hex_bloc/user/domain/parameters/registration_parameters.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

class RegistrationUseCase implements UseCase<User, RegistrationParameters> {
  GetIt getIt = GetIt.instance;

  @override
  Future<Either<Failure, User>> call(RegistrationParameters params) {
    if (!params.email.contains('@')) {
      return Future.value(Left(InvalidEmail()));
    }
    if (params.password.length < 8) {
      return Future.value(Left(PasswordTooShort()));
    }
    if (params.password != params.confirmPassword) {
      return Future.value(Left(PasswordDoesNotMatch()));
    }
    return getIt<AuthenticationService>()
        .register(params.email, params.name, params.password);
  }
}
