import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.color,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData? icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }
}
