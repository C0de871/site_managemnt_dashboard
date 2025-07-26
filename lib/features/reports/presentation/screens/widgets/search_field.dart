import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onPressed,
  });

  final String hintText;
  final TextEditingController controller;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextField(
      controller: controller,
      onSubmitted: (value) {
        onPressed();
      },
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        isDense: true,
      ),
    );
  }
}
