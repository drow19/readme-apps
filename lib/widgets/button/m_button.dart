import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';

enum MSizeButton { large, medium, small }

enum MSizeIconButton { extraSmall, small, large, medium }

enum MTypeButton { filled, outline }

enum MVariant { normal, icon }

enum MShape { circle, square }

class MButton extends StatelessWidget {
  final IconData? icon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? buttonText;
  final Color? iconColor;
  final Color buttonColor;
  final Color? textColor;
  final Color? lineColor;
  final VoidCallback onPressed;
  final MSizeButton sizeButton;
  final MTypeButton typeButton;
  final MVariant variant;
  final MShape? shape;
  final BoxShadow shadow;
  final bool disable;
  final double sizeHeight;
  final double sizeIcon;
  final double marginIcon;
  final double borderRadius;
  final Color? badgeColor;
  final bool badge;
  final Color? borderColor;

  const MButton({
    super.key,
    this.buttonText,
    required this.onPressed,
    this.icon,
    this.prefixIcon,
    this.suffixIcon,
    this.iconColor,
    required this.buttonColor,
    this.textColor,
    this.lineColor,
    this.sizeButton = MSizeButton.medium,
    this.typeButton = MTypeButton.filled,
    this.variant = MVariant.normal,
    this.shape = MShape.circle,
    required this.shadow,
    this.disable = false,
    required this.sizeHeight,
    required this.sizeIcon,
    required this.marginIcon,
    required this.borderRadius,
    this.badgeColor,
    this.badge = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return (variant == MVariant.icon)
        ? _buildIconButton()
        : _buildButtonWidget();
  }

  Widget _buildIconButton() {
    return Stack(
      children: [
        Container(
          width: sizeHeight,
          height: sizeHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: borderColor == null
                ? null
                : Border.all(color: borderColor ?? MColors.p1),
            shape:
                (shape == MShape.circle) ? BoxShape.circle : BoxShape.rectangle,
            boxShadow: [shadow],
            color: disable ? buttonColor.withOpacity(0.3) : buttonColor,
            borderRadius: (shape == MShape.circle)
                ? null
                : BorderRadius.circular(borderRadius),
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 1,
            onPressed: () => disable ? null : onPressed(),
            icon: MIcon(
              icon,
              color: disable ? iconColor!.withOpacity(0.3) : iconColor,
              size: sizeIcon,
            ),
          ),
        ),
        Positioned(
          top: sizeHeight * 0.01,
          right: sizeHeight * 0.01,
          child: badge
              ? Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: badgeColor ?? MColors.orange,
                    shape: BoxShape.circle,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }

  Widget _buildButtonWidget() {
    return Container(
      height: sizeHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [shadow],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          disabledBackgroundColor: (typeButton == MTypeButton.filled)
              ? buttonColor.withOpacity(0.3)
              : MColors.n6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor:
              (typeButton == MTypeButton.filled) ? buttonColor : MColors.n6,
          side: (typeButton == MTypeButton.filled)
              ? null
              : BorderSide(
                  color: disable ? lineColor!.withOpacity(0.3) : lineColor!,
                ),
          fixedSize: Size.fromHeight(sizeHeight),
          padding: (sizeButton == MSizeButton.large)
              ? const EdgeInsets.symmetric(horizontal: 28)
              : const EdgeInsets.symmetric(horizontal: 16),
        ),
        onPressed: disable ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null)
              MIcon(
                prefixIcon,
                color: (typeButton == MTypeButton.filled)
                    ? textColor
                    : disable
                        ? lineColor!.withOpacity(0.3)
                        : lineColor,
                size: sizeIcon,
              ),
            if (prefixIcon != null)
              SizedBox(
                width: marginIcon,
              ),
            _buildText(
              sizeButton,
              buttonText ?? '',
              (typeButton == MTypeButton.filled)
                  ? textColor
                  : disable
                      ? lineColor!.withOpacity(0.3)
                      : lineColor,
              _textAlignButton(prefixIcon, suffixIcon),
            ),
            if (suffixIcon != null)
              SizedBox(
                width: marginIcon,
              ),
            if (suffixIcon != null)
              MIcon(
                suffixIcon,
                color: (typeButton == MTypeButton.filled)
                    ? textColor
                    : disable
                        ? lineColor!.withOpacity(0.3)
                        : lineColor,
                size: sizeIcon,
              ),
          ],
        ),
      ),
    );
  }

  TextAlign _textAlignButton(IconData? prefixIcon, IconData? suffixIcon) {
    if (prefixIcon != null && suffixIcon != null) {
      return TextAlign.center;
    } else if (prefixIcon != null) {
      return TextAlign.left;
    } else if (suffixIcon != null) {
      return TextAlign.right;
    } else {
      return TextAlign.center;
    }
  }

  Widget _buildText(
    MSizeButton sizeButton,
    String title,
    Color? textColor,
    TextAlign textAlign,
  ) {
    return Flexible(
      child: Text(
        title,
        maxLines: (sizeButton == MSizeButton.large) ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: (sizeButton == MSizeButton.large)
            ? MTypography.title.copyWith(color: textColor)
            : (sizeButton == MSizeButton.small)
                ? MTypography.caption1.copyWith(color: textColor)
                : MTypography.body2.copyWith(color: textColor),
      ),
    );
  }
}
