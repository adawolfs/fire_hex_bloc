import 'package:fire_hex_bloc/user/domain/entities/user.dart';

abstract class AuthenticationState {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationSucceeded extends AuthenticationState {
  final User user;
  const AuthenticationSucceeded(this.user);
}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  const AuthenticationFailed(this.message);
}

class AuthenticationSignedOut extends AuthenticationState {
  const AuthenticationSignedOut();
}
