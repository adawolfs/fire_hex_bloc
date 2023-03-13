import 'package:fire_hex_bloc/common/domain/entities/entity.dart';

class User implements Entity {
  final String id;
  final String name;
  final String email;
  User({
    this.id = '',
    required this.name,
    required this.email,
  });
}
