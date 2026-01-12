import 'package:flutter/material.dart';

class PrimaryFilledButton extends FilledButton {
  PrimaryFilledButton({
    super.key,
    required super.onPressed,
    required super.child,
  }) : super(
         style: FilledButton.styleFrom(
           padding: EdgeInsets.symmetric(vertical: 20),
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(12),
           ),
         ),
       );
}
