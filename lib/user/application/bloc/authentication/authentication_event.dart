import 'package:fire_hex_bloc/user/domain/entities/user.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationCheckStatus extends AuthenticationEvent {
  final User? user;
  const AuthenticationCheckStatus(this.user);
}

class AuthenticationStarted extends AuthenticationEvent {
  const AuthenticationStarted(this.user);
  final String user;
}
