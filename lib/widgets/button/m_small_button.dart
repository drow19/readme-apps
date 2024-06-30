import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_shadow.dart';
import 'package:book_store_apps/widgets/button/m_button.dart';
import 'package:flutter/material.dart';

class MSmallButton extends StatelessWidget {
  ///The button's title arguments must not be null.
  final String title;

  ///The button's background fill color.
  final Color buttonColor;

  ///The button's text color.
  final Color textColor;

  ///The button's outline color when set typeButton = WTypeButton.outline
  final Color outlineColor;

  ///The button's type [filled, outline]
  ///
  /// {@tool snippet}
  /// Can be used, as follows:
  ///
  /// ```dart
  /// WLargeButton(
  ///   typeButton: typeButton.filled,
  /// )
  /// ```
  /// {@end-tool}
  final MTypeButton typeButton;

  ///The [autofocus] and [clipBehavior] arguments must not be null.
  final VoidCallback onPressed;

  ///The button's prefix icon
  ///
  /// If null, this prefix icon will not show.
  final IconData? prefixIcon;

  ///The button's suffix icon
  ///
  ///If null, this suffix icon will not show.
  final IconData? suffixIcon;

  ///The button's shadow
  final BoxShadow? shadow;

  ///If true the button is disable, ignores function onPressed
  ///and button color is opacity 30%
  final bool disable;

  const MSmallButton({
    super.key,
    required this.title,
    this.buttonColor = MColors.p2,
    this.outlineColor = MColors.p2,
    required this.typeButton,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.textColor = MColors.n6,
    this.shadow,
    this.disable = false,
  });
  @override
  Widget build(BuildContext context) {
    // size button
    const double sizeHeight = 32;
    const double sizeIcon = 16;
    const double marginIcon = 8;
    const double borderRadius = 16;

    return MButton(
      buttonText: title,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      buttonColor: buttonColor,
      textColor: textColor,
      lineColor: outlineColor,
      sizeButton: MSizeButton.small,
      typeButton: typeButton,
      onPressed: onPressed,
      sizeHeight: sizeHeight,
      sizeIcon: sizeIcon,
      marginIcon: marginIcon,
      borderRadius: borderRadius,
      shadow: shadow ?? MShadow.p3Shadow3,
      disable: disable,
    );
  }
}