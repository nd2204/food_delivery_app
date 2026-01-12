import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.onPressed,
    this.size = 56,
    this.backgroundColor = Colors.white,
    this.icon = Icons.chevron_left_rounded,
    this.iconColor = Colors.black,
    this.iconSize,
    this.elevation = 0,
    this.shadowColor,
    this.border,
    this.tooltip,
    this.semanticLabel,
  });

  final VoidCallback? onPressed;

  /// Diameter of the circle.
  final double size;

  final Color backgroundColor;

  final IconData icon;
  final Color iconColor;

  /// If null, defaults to size * 0.55.
  final double? iconSize;

  /// Material elevation (adds shadow).
  final double elevation;

  final Color? shadowColor;

  /// Optional border (e.g. BorderSide(color: Colors.black12)).
  final BorderSide? border;

  final String? tooltip;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final double effectiveIconSize = iconSize ?? size * 0.55;

    final button = Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor ?? Colors.black26,
      shape: CircleBorder(side: border ?? BorderSide.none),
      clipBehavior: Clip.antiAlias, // keeps ripple inside circle
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Icon(icon, size: effectiveIconSize, color: iconColor),
          ),
        ),
      ),
    );

    // Optional semantics/tooltip.
    final wrapped = Semantics(
      button: true,
      label: semanticLabel,
      child: tooltip == null
          ? button
          : Tooltip(message: tooltip!, child: button),
    );

    return wrapped;
  }
}
