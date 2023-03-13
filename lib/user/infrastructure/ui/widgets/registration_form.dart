import 'package:fire_hex_bloc/user/application/bloc/registration/registration_bloc.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_event.dart';
import 'package:fire_hex_bloc/user/application/bloc/registration/registration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final confirmPasswordFieldController = TextEditingController();
  RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is RegistrationLoading) {
          return const CircularProgressIndicator();
        }
        if (state is RegistrationSuccess) {
          return const Text('Success');
        }
        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                key: const Key('registerForm_nameInput_textField'),
                controller: nameFieldController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Insert your name',
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                key: const Key('registerForm_emailInput_textField'),
                controller: emailFieldController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'example@gmail.com',
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                key: const Key('registerForm_passwordInput_textField'),
                controller: passwordFieldController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Password',
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              TextFormField(
                key: const Key('registerForm_confirmPasswordInput_textField'),
                controller: confirmPasswordFieldController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.lock),
                  hintText: 'Confirm Password',
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  key: const Key('registerForm_register_elevatedButton'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<RegistrationBloc>(context).add(
                        RegistrationWithEmailAndPasswordPressed(
                          name: nameFieldController.text,
                          email: emailFieldController.text,
                          password: passwordFieldController.text,
                          confirmPassword: confirmPasswordFieldController.text,
                        ),
                      );
                    }
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
