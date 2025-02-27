import 'package:blabla_project/theme/theme.dart';
import 'package:flutter/material.dart';

///
/// Icon Button rendering for whole app
///
class BlaIconButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;

  const BlaIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MouseRegion( // change mouse cursor when on hover over the button
      cursor: SystemMouseCursors.click, 
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(icon, size: BlaSize.icon,color: BlaColors.primary,),
      ),
    );
  }
}
