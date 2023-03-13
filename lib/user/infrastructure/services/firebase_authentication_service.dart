import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart' as user;
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/user/infrastructure/models/user_model.dart';
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
      String email, String name, String password) async {
    try {
      UserCredential credentials = await getIt<FirebaseAuth>()
          .createUserWithEmailAndPassword(email: email, password: password);

      return Right(UserModel(
        id: credentials.user!.uid,
        name: name,
        email: email,
      ));
    } on FirebaseAuthException {
      return Left(RegistrationFailure());
    }
  }

  @override
  Stream<user.User?> checkStatus() {
    return getIt<FirebaseAuth>().authStateChanges().asyncMap((event) {
      return event == null
          ? null
          : UserModel(
              id: event.uid,
              name: '',
              email: event.email!,
            );
    });
  }
}
