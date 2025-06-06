import 'package:flutter/material.dart';

class FailedSnackBar extends SnackBar {
  final String message;
  FailedSnackBar({super.key, required this.message})
      : super(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.red),
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
