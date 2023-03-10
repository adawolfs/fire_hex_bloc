import 'package:fire_hex_bloc/common/domain/parameters.dart';

class RegistrationParameters implements Parameters {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  RegistrationParameters({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}
