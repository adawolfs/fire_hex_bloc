import 'package:fire_hex_bloc/common/domain/failure.dart';

class RegistrationFailure implements Failure {
  @override
  String toString() => 'Registration Failure';
}

class EmailAlreadyInUseFailure extends RegistrationFailure {
  @override
  String toString() => 'Email already in use';
}

class InvalidPasswordFailure extends RegistrationFailure {
  @override
  String toString() => 'Invalid password';
}

class InvalidEmailFailure extends RegistrationFailure {
  @override
  String toString() => 'Invalid email';
}
