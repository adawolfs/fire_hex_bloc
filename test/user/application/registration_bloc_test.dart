import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_bloc.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_event.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_state.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/user/domain/failures/registration_failures.dart';
import 'package:fire_hex_bloc/user/domain/repositories/user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/repository/firebase_user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/services/firebase_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../mock/authentication_repository_mock.dart';

void main() {
  group('Registration Bloc Test', () {
    setUp(() {
      GetIt.instance.registerSingleton<FirebaseAuth>(
        MockFirebaseAuth(
          mockUser: MockUser(
            isAnonymous: false,
            email: validEmail,
            displayName: validEmail,
          ),
        ),
      );
      GetIt.instance.registerSingleton<FirebaseFirestore>(
        FakeFirebaseFirestore(),
      );
      GetIt.instance.registerSingleton<AuthenticationService>(
        FirebaseAuthenticationService(),
      );
      GetIt.instance.registerSingleton<UserRepository>(
        FirebaseUserRepository(),
      );
      GetIt.instance.registerSingleton<RegistrationUseCase>(
        RegistrationUseCase(),
      );
    });
    tearDown(() {
      GetIt.instance.unregister(instance: GetIt.instance<FirebaseAuth>());
      GetIt.instance.unregister(instance: GetIt.instance<FirebaseFirestore>());
      GetIt.instance
          .unregister(instance: GetIt.instance<AuthenticationService>());
      GetIt.instance.unregister(instance: GetIt.instance<UserRepository>());
      GetIt.instance
          .unregister(instance: GetIt.instance<RegistrationUseCase>());
    });
    blocTest<RegistrationBloc, RegistrationState>(
        'emits [] when nothing is added',
        build: () => RegistrationBloc(),
        expect: () => const []);
    blocTest<RegistrationBloc, RegistrationState>(
      'emits [RegistrationLoading, RegistrationSuccess] when RegistrationWithEmailAndPasswordPressed is added.',
      build: () => RegistrationBloc(),
      act: (bloc) => bloc.add(const RegistrationWithEmailAndPasswordPressed(
        name: validName,
        email: validEmail,
        password: validPassword,
        confirmPassword: validPassword,
      )),
      expect: () => [
        RegistrationLoading(),
        RegistrationSuccess(),
      ],
    );
    blocTest<RegistrationBloc, RegistrationState>(
      'emits [RegistrationLoading, RegistrationFailure] when RegistrationWithEmailAndPasswordPressed is added.',
      build: () {
        return RegistrationBloc();
      },
      act: (bloc) => bloc.add(const RegistrationWithEmailAndPasswordPressed(
        name: validName,
        email: validEmail,
        password: validPassword,
        confirmPassword: '',
      )),
      expect: () => [
        RegistrationLoading(),
        RegistrationFailed(PasswordDoesNotMatch().message),
      ],
    );
  });
}
