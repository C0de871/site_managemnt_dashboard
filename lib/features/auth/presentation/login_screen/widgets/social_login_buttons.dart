// main.dart

import 'package:flutter/material.dart';

import 'social_button.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SocialButton(
          icon: Icons.g_mobiledata,
          text: 'Continue with Google',
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          borderColor: Colors.grey.shade300,
          onPressed: () {
            // Handle Google login
          },
        ),
        const SizedBox(height: 12),
        SocialButton(
          icon: Icons.facebook,
          text: 'Continue with Facebook',
          backgroundColor: const Color(0xFF1877F2), // Facebook blue
          textColor: Colors.white,
          onPressed: () {
            // Handle Facebook login
          },
        ),
        const SizedBox(height: 12),
        SocialButton(
          icon: Icons.apple,
          text: 'Continue with Apple',
          backgroundColor: Colors.black,
          textColor: Colors.white,
          onPressed: () {
            // Handle Apple login
          },
        ),
      ],
    );
  }
}
