import 'package:flutter/material.dart';

typedef TextFormFieldValidator = String? Function(String?)?;

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final TextFormFieldValidator validator;
  final TextInputType keyboardType;
  final Widget? suffix;
  final bool obscureText;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    final labelColor = colorscheme.onSurface;
    final fill = colorscheme.secondaryContainer;
    final hint = colorscheme.onSecondaryContainer; // grey hint text

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(color: labelColor, letterSpacing: 1.0),
        ),
        const SizedBox(height: 14),

        // The rounded input container
        Container(
          decoration: BoxDecoration(
            color: fill,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            cursorColor: labelColor,

            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,

              contentPadding: const EdgeInsets.all(20),

              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: hint,
              ),

              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: suffix,
              ),
              suffixIconConstraints: const BoxConstraints(
                minWidth: 40,
                minHeight: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
