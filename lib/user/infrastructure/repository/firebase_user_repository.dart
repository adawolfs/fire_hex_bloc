import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_hex_bloc/user/domain/entities/user.dart';
import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/domain/repositories/user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/models/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

class FirebaseUserRepository implements UserRepository {
  GetIt getIt = GetIt.instance;
  final String documentPath = 'users';
  late final CollectionReference<UserModel> _userRef;
  FirebaseUserRepository() {
    _userRef = getIt<FirebaseFirestore>()
        .collection(documentPath)
        .withConverter<UserModel>(
          fromFirestore: (snapshots, _) =>
              UserModel.fromMap(snapshots.data()!, snapshots.id),
          toFirestore: (user, _) => user.toFirebaseMap(),
        );
  }

  @override
  Future<Either<Failure, User>> createUser(UserModel user,
      {bool customId = true}) async {
    if (customId) {
      await getIt<FirebaseFirestore>()
          .doc('$documentPath/${user.id}')
          .set(user.toFirebaseMap(), SetOptions(merge: false));
      return Right(user);
    }
    return _userRef
        .add(user)
        .then((doc) => doc.get().then((value) => Right(value.data()!)));
  }

  @override
  Future<Either<Failure, User>> getUser(String uid) async {
    var snapshot = await _userRef.doc(uid).get();
    return Right(snapshot.data() as User);
  }
}
