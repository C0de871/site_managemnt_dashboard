// main.dart

import 'package:flutter/material.dart';

class RegisterPrompt extends StatelessWidget {
  const RegisterPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account?',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        TextButton(
          onPressed: () {
            // Handle registration
          },
          child: Text(
            'Register',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
