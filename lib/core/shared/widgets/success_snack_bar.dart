import 'package:flutter/material.dart';

class SuccessSnackBar extends SnackBar {
  final String message;
  SuccessSnackBar({
    super.key,
    required this.message,
  }) : super(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.green),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          elevation: 6.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
}
