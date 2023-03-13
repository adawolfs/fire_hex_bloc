import 'package:fire_hex_bloc/user/application/bloc/authentication/authentication_bloc.dart';
import 'package:fire_hex_bloc/user/application/bloc/authentication/authentication_state.dart';
import 'package:fire_hex_bloc/user/infrastructure/ui/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RouteNames {
  static String home = '/';
  static String register = '/register';
}

class Routes extends GoRouter {
  Routes(String initialLocation)
      : super(
          initialLocation: initialLocation,
          routes: <RouteBase>[
            GoRoute(
              path: RouteNames.home,
              builder: (BuildContext context, GoRouterState state) {
                return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return const Scaffold(
                      body: Center(
                        child: Text('Home Page'),
                      ),
                    );
                  },
                );
              },
            ),
            GoRoute(
              path: RouteNames.register,
              builder: (BuildContext context, GoRouterState state) {
                return const RegistrationPage();
              },
            ),
          ],
        );
}
