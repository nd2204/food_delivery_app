import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final Border? border;
  final VoidCallback onPressed;

  const SocialButton({
    super.key,
    required this.icon,
    required this.background,
    required this.onPressed,
    this.iconColor = Colors.white,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onPressed,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          border: border,
        ),
        child: Center(child: FaIcon(icon, size: 22, color: iconColor)),
      ),
    );
  }
}
