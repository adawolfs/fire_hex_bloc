import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart' as user;
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

class FirebaseAuthenticationService implements AuthenticationService {
  GetIt getIt = GetIt.instance;
  @override
  Future<Either<Failure, user.User>> login(
      String email, String password) async {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, user.User>> register(
      String email, String password) async {
    try {
      await getIt<FirebaseAuth>()
          .createUserWithEmailAndPassword(email: email, password: password);
      return Right(
        user.User(),
      );
    } on FirebaseAuthException {
      return Left(RegistrationFailure());
    }
  }
}
