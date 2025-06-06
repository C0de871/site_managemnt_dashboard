import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
    this.label, {
    super.key,
    required this.icon,
    this.isNumber = false,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.onPressedSuffixIcon,
    this.obsecure = false,
  });

  final String label;
  final IconData icon;
  final bool isNumber;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final VoidCallback? onPressedSuffixIcon;
  final bool obsecure;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.isNumber ? TextInputType.number : TextInputType.text,
        validator: widget.validator,
        obscureText: widget.obsecure,
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon == null
              ? null
              : IconButton(
                  icon: Icon(widget.suffixIcon),
                  onPressed: widget.onPressedSuffixIcon,
                ),
          labelText: widget.label,
          prefixIcon: Icon(
            widget.icon,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
