import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.colorScheme,
    required this.message,
    required this.onPressed,
    required this.title,
  });

  final ColorScheme colorScheme;
  final String message;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(fontSize: 20, color: colorScheme.error)),
          const SizedBox(height: 8),
          Text(message, style: TextStyle(color: colorScheme.onSurfaceVariant)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
