import 'package:equatable/equatable.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();

  @override
  List<Object?> get props => [];
}

class RegistrationLoading extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationSuccess extends RegistrationState {
  @override
  List<Object?> get props => [];
}

class RegistrationFailed extends RegistrationState {
  final String message;
  const RegistrationFailed(this.message);
  @override
  List<Object?> get props => [message];
}
