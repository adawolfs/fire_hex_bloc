import 'package:fire_hex_bloc/user/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String documentId) {
    return UserModel(
      id: documentId,
      name: data['name'],
      email: data['email'],
    );
  }
  Map<String, Object?> toFirebaseMap() {
    return <String, Object?>{
      'name': name,
      'email': email,
    };
  }
}
