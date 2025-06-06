// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/login_cubit.dart';
import 'login_button.dart';
import 'password_field.dart';
import 'username_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      autovalidateMode: AutovalidateMode.always,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          UsernameField(),
          SizedBox(height: 16),
          PasswordField(),
          // SizedBox(height: 16),
          // RememberMe(),
          SizedBox(height: 24),
          LoginButton(),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
