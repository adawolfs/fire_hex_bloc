import 'package:fire_hex_bloc/common/domain/failure.dart';

class RegistrationFailure extends Failure {
  @override
  final String message;
  RegistrationFailure({this.message = 'Registration Failure'});
}

class InvalidEmail extends RegistrationFailure {
  InvalidEmail() : super(message: 'Invalid Email');
}

class PasswordDoesNotMatch extends RegistrationFailure {
  PasswordDoesNotMatch() : super(message: 'Password does not match');
}

class PasswordTooShort extends RegistrationFailure {
  PasswordTooShort()
      : super(message: 'Password too short, minimum 8 characters');
}
