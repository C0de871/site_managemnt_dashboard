import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({
    super.key,
    required this.text,
    required this.press,
    this.width = double.infinity,

    this.color,
    this.disabledColor,
    this.disabled = false,
    this.foregroundColor = Colors.white,
    this.borderRadius = 12,
    this.fontWeight = FontWeight.bold,
    this.iconPath,
    this.iconSize,
    this.icon,
  }) : assert(
         iconPath == null || icon == null,
         'can not have both icon and iconPath',
       ) {
    if (iconPath != null) {
      _icon = SvgPicture.asset(iconPath!, width: iconSize, height: iconSize);
    } else if (icon != null) {
      _icon = Icon(icon, size: iconSize);
    }
  }

  final String text;
  final void Function()? press;
  final double? width;
  final IconData? icon;
  final String? iconPath;
  final double? iconSize;
  final Color? color;
  final bool disabled;
  final Color? disabledColor;
  final Color? foregroundColor;
  final double? borderRadius;
  final FontWeight fontWeight;
  Widget? _icon;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 56,
      child: ElevatedButton(
        onPressed: disabled ? null : press,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor:
              disabledColor ?? Theme.of(context).colorScheme.tertiary,
          disabledForegroundColor:
              disabledColor ?? Theme.of(context).colorScheme.onTertiary,
          backgroundColor:
              disabled
                  ? disabledColor ?? Theme.of(context).colorScheme.tertiary
                  : color ?? Theme.of(context).colorScheme.primary,
          foregroundColor:
              foregroundColor ?? Colors.white, // Text (and icon) color
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? 12,
            ), // Rounded corners
          ),
          elevation: 2, // Shadow
        ),
        child:
            _icon != null
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _icon!,
                    SizedBox(width: 10),
                    Text(
                      text,
                      style: TextStyle(fontSize: 16, fontWeight: fontWeight),
                    ),
                  ],
                )
                : Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: fontWeight),
                ),
      ),
    );
  }
}
