import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/domain/repositories/registration_repository.dart';
import 'package:fire_hex_bloc/common/domain/use_case.dart';
import 'package:fire_hex_bloc/user/domain/parameters/registration_parameters.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

class RegistrationUseCase implements UseCase<User, RegistrationParameters> {
  GetIt getIt = GetIt.instance;

  @override
  Future<Either<Failure, User>> call(RegistrationParameters params) {
    return getIt<RegistrationRepository>().register(params);
  }
}
