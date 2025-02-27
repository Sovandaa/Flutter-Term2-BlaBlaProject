import 'package:blabla_project/theme/theme.dart';
import 'package:blabla_project/widgets/actions/bla_icon_button.dart';
import 'package:flutter/material.dart';

///
/// This tile represents a selectable tile on the Ride Preference Screen
///
class RidePrefInputTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;

  // if true, text is display ligher
  final bool isPlaceHolder;

  // right button, optional
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefInputTile(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.leftIcon,
      this.rightIcon,
      this.onRightIconPressed,
      this.isPlaceHolder = false});

  @override
  Widget build(BuildContext context) {
    Color textColor =
        isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;

    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(
          fontSize: 14, color: textColor
        ),
      ),
      leading: Icon(
        leftIcon,
        size: BlaSize.icon,
        color: BlaColors.iconLight,
      ),
      trailing: rightIcon != null
        ? BlaIconButton(icon: rightIcon, onPressed: onRightIconPressed)
        : null,
    );
  }
}
