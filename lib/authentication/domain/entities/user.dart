import 'package:equatable/equatable.dart';
import 'package:fire_hex_bloc/common/domain/entity.dart';

class User extends Equatable implements Entity {
  final String email;
  final String password;

  const User({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
