import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/domain/parameters/registration_parameters.dart';
import 'package:fpdart/fpdart.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, User>> register(RegistrationParameters params);
}
