// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared/widgets/custom_text_field.dart';
import '../cubits/login_cubit.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      "Username",
      icon: Icons.person_outline,
      controller: context.read<LoginCubit>().usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }
}
