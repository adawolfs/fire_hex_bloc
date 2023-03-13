import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/infrastructure/services/firebase_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('Registration Use Case', () {
    final user = MockUser(
      isAnonymous: false,
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    GetIt.instance.registerSingleton<FirebaseAuth>(
      MockFirebaseAuth(mockUser: user),
    );
    GetIt.instance.registerSingleton<AuthenticationService>(
      FirebaseAuthenticationService(),
    );
    test('Should be a subclass of UseCase', () async {
      var repository = FirebaseAuthenticationService();
      expect(repository, isA<AuthenticationService>());
      repository.register(user.email!, user.displayName!, '123456');
    });
  });
}
