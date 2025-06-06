import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 20,
              color: colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
