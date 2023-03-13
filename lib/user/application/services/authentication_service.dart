import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthenticationService {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(
    String email,
    String name,
    String password,
  );
  Stream<User?> checkStatus();
  Future<void> logout();
}
