import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/labeled_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSecondaryContainer;

    return LabeledTextField(
      label: widget.label,
      obscureText: obscureText,
      hintText: widget.hintText,
      controller: widget.controller,
      suffix: IconButton(
        onPressed: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        icon: Icon(Icons.remove_red_eye_sharp, color: iconColor),
      ),
    );
  }
}
