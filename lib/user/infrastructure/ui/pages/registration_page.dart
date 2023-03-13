import 'package:fire_hex_bloc/common/infrastructure/ui/base_page.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_bloc.dart';
import 'package:fire_hex_bloc/user/infrastructure/ui/widgets/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends BasePage {
  const RegistrationPage({super.key});

  @override
  Widget body(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: RegistrationForm(),
        ),
      ),
    );
  }
}
