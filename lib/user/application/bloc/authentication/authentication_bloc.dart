import 'package:fire_hex_bloc/user/application/bloc/authentication/authentication_event.dart';
import 'package:fire_hex_bloc/user/application/bloc/authentication/authentication_state.dart';
import 'package:fire_hex_bloc/user/application/services/authentication_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  GetIt getIt = GetIt.instance;
  AuthenticationBloc() : super(const AuthenticationInitial()) {
    getIt<AuthenticationService>().checkStatus().listen((value) {
      add(AuthenticationCheckStatus(value));
    });
    on<AuthenticationCheckStatus>((event, emit) {
      if (event.user != null) {
        emit(AuthenticationSucceeded(event.user!));
      } else {
        emit(const AuthenticationSignedOut());
      }
    });
  }
}
