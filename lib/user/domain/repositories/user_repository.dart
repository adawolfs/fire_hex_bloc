import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/user/infrastructure/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> createUser(UserModel user, {bool customId});
  Future<Either<Failure, User>> getUser(String uid);
}
