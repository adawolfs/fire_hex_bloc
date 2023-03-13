import 'package:fire_hex_bloc/common/domain/failure.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_event.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_state.dart';
import 'package:fire_hex_bloc/user/application/use_cases/registration_use_case.dart';
import 'package:fire_hex_bloc/user/domain/parameters/registration_parameters.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  GetIt getIt = GetIt.instance;
  RegistrationBloc() : super(const RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) {});
    on<RegistrationWithEmailAndPasswordPressed>(
      (event, emit) async {
        emit(RegistrationLoading());
        await getIt<RegistrationUseCase>()
            .call(RegistrationParameters(
              name: event.name,
              email: event.email,
              password: event.password,
              confirmPassword: event.confirmPassword,
            ))
            .then(
              (value) => value.fold(
                (l) => emit(RegistrationFailed(l.message)),
                (r) => emit(RegistrationSuccess()),
              ),
            )
            .catchError(
              (e) => emit(
                RegistrationFailed(e.toString()),
              ),
            );
      },
    );
  }
}
