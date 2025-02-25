import 'package:blabla_project/theme/theme.dart';
import 'package:flutter/material.dart';

// represent types of button
enum BlaButtonType { primary, secondary }

///
/// BlaButton: a resuable widget for button (primary or secondary)
///

class BlaButton extends StatelessWidget {
  final String text;
  final BlaButtonType type;
  final IconData? icon;
  final double borderRadius;
  final VoidCallback onPressed;

  const BlaButton(
      {super.key,
      required this.text,
      this.type = BlaButtonType.primary, // set defualt to primary
      this.icon,
      this.borderRadius = BlaSpacings.radius,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (type) {
      case BlaButtonType.primary:
        bgColor = BlaColors.primary;
        textColor = BlaColors.white;
        break;
      case BlaButtonType.secondary:
        bgColor = BlaColors.white;
        textColor = BlaColors.primary;
        break;
    }

    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(
              vertical: BlaSpacings.m, horizontal: BlaSpacings.l),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, size: 20, color: textColor),
            if (icon != null)const SizedBox(width: 8),
            Text(
              text,
              style: BlaTextStyles.button.copyWith(color: textColor),
            ),
          ],
        ));
  }
}
