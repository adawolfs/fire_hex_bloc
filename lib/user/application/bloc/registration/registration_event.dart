abstract class RegistrationEvent {
  const RegistrationEvent();
}

class RegistrationWithEmailAndPasswordPressed extends RegistrationEvent {
  const RegistrationWithEmailAndPasswordPressed({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  @override
  String toString() =>
      'RegistrationWithEmailAndPasswordPressed { email: $email, password: $password }';
}
