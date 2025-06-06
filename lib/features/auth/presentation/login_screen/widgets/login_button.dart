// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/login_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: switch (state) {
            LoginLoading() => null,
            _ => () {
                if (context.read<LoginCubit>().formKey.currentState!.validate()) context.read<LoginCubit>().login();
              },
          },
          child: switch (state) {
            LoginLoading() => const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            _ => const Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          },
        );
      },
    );
  }
}
