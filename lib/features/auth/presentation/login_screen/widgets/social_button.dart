// main.dart

import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: borderColor != null ? BorderSide(color: borderColor!) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
