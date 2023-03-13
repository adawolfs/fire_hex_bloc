import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_hex_bloc/common/application/router/router.dart';
import 'package:fire_hex_bloc/firebase_options.dart';
import 'package:fire_hex_bloc/user/application/bloc/authentication/authentication_bloc.dart';
import 'package:fire_hex_bloc/user/application/bloc/authentication/authentication_state.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/user/domain/repositories/user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/repository/firebase_user_repository.dart';
import 'package:fire_hex_bloc/user/infrastructure/services/firebase_authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  GetIt.instance.registerSingleton<FirebaseAuth>(
    FirebaseAuth.instance,
  );
  GetIt.instance.registerSingleton<FirebaseFirestore>(
    FirebaseFirestore.instance,
  );
  GetIt.instance.registerSingleton<UserRepository>(
    FirebaseUserRepository(),
  );
  GetIt.instance.registerSingleton<AuthenticationService>(
      FirebaseAuthenticationService());
  GetIt.instance.registerSingleton<RegistrationUseCase>(RegistrationUseCase());
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationBloc(),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {},
          builder: (context, state) {
            late GoRouter router;
            if (state is AuthenticationInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AuthenticationSignedOut) {
              router = Routes(RouteNames.register);
            }

            if (state is AuthenticationSucceeded) {
              router = Routes(RouteNames.home);
            }

            return MaterialApp.router(
              key: const Key('Application'),
              title: 'Fire Hex Bloc ',
              routerConfig: router,
            );
          },
        ));
  }
}
