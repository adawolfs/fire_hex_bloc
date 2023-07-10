import 'package:fire_hex_bloc/authentication/domain/entities/user.dart';
import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> register(User user);
}
