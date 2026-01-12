import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final VoidCallback? onTap;

  const AppSearchBar({
    super.key,
    this.controller,
    this.onTap,
    this.keyboardType = TextInputType.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final colorscheme = Theme.of(context).colorScheme;
    final labelColor = colorscheme.onSurface;
    final fill = colorscheme.secondaryContainer;
    final hint = colorscheme.onSecondaryContainer; // grey hint text

    // The rounded input container
    return Container(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.centerLeft,
      child: TextField(
        onTap: onTap,
        controller: controller,
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
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              FontAwesomeIcons.magnifyingGlass,
              color: hint,
              weight: 0.1,
              size: 24,
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: controller == null || controller!.value.text.isEmpty
                ? null
                : Icon(Icons.cancel_rounded),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
      ),
    );
  }
}
