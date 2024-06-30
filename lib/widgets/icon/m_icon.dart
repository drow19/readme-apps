import 'package:flutter/material.dart';

/// A graphical icon widget drawn with a glyph from a font described in
/// an [IconData] such as material's predefined [IconData]s in [Icons].
///
/// Icons are not interactive. For an interactive icon, consider material's
/// [IconButton].
///
/// There must be an ambient [Directionality] widget when using [MIcon].
/// Typically this is introduced automatically by the [WidgetsApp] or
/// [MaterialApp].
///
/// This widget assumes that the rendered icon is squared. Non-squared icons may
/// render incorrectly.
///
/// {@tool snippet}
///
/// This example shows how to create a [Row] of [Icon]s in different colors and
/// sizes. The first [Icon] uses a [semanticLabel] to announce in accessibility
/// modes like TalkBack and VoiceOver.
///
/// ![The following code snippet would generate a row of icons consisting of a pink heart, a green musical note, and a blue umbrella, each progressively bigger than the last.](https://flutter.github.io/assets-for-api-docs/assets/widgets/icon.png)
///
/// ```dart
/// Row(
///   mainAxisAlignment: MainAxisAlignment.spaceAround,
///   children: const <Widget>[
///     MIcon(
///       Icons.favorite,
///       color: Colors.pink,
///       size: 24.0,
///       semanticLabel: 'Text to announce in accessibility modes',
///     ),
///     MIcon(
///       Icons.audioTrack,
///       color: Colors.green,
///       size: 30.0,
///     ),
///     MIcon(
///       Icons.beach_access,
///       color: Colors.blue,
///       size: 36.0,
///     ),
///   ],
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [IconButton], for interactive icons.
///  * [Icons], the library of Material Icons available for use with this class.
///  * [ImageIcon], for showing icons from [AssetImage]s or other [ImageProvider]s.
class MIcon extends StatelessWidget {
  const MIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.gradientColors,
    this.semanticLabel,
    this.textDirection,
    this.shadows,
    this.badgeColor,
    this.badge = false,
  });

  /// The icon to display. The available icons are described in [Icons].
  ///
  /// The icon can be null, in which case the widget will render as an empty
  /// space of the specified [size].
  final IconData? icon;

  /// The size of the icon in logical pixels.
  ///
  /// Icons occupy a square with width and height equal to size.
  ///
  final double? size;

  /// The color to use when drawing the icon.
  ///
  /// {@tool snippet}
  /// Typically, a Material Design color will be used, as follows:
  ///
  /// ```dart
  /// MIcon(
  ///   Icons.leave,
  ///   color: Colors.blue.shade400,
  /// )
  /// ```
  /// {@end-tool}
  final Color? color;

  /// The gradient colors to use when drawing the icon.
  ///
  /// {@tool snippet}
  /// Typically, a Material Design color will be used, as follows:
  ///
  /// ```dart
  /// MIcon(
  ///   Icons.leave,
  ///   gradientColors: ,
  /// )
  /// ```
  /// {@end-tool}
  final List<Color>? gradientColors;

  /// Semantic label for the icon.
  ///
  /// Announced in accessibility modes (e.g TalkBack/VoiceOver).
  /// This label does not show in the UI.
  ///
  ///  * [SemanticsProperties.label], which is set to [semanticLabel] in the
  ///    underlying	 [Semantics] widget.
  final String? semanticLabel;

  /// The text direction to use for rendering the icon.
  ///
  /// If this is null, the ambient [Directionality] is used instead.
  ///
  /// Some icons follow the reading direction. For example, "back" buttons point
  /// left in left-to-right environments and right in right-to-left
  /// environments. Such icons have their [IconData.matchTextDirection] field
  /// set to true, and the [MIcon] widget uses the [textDirection] to determine
  /// the orientation in which to draw the icon.
  ///
  /// This property has no effect if the [icon]'s [IconData.matchTextDirection]
  /// field is false, but for consistency a text direction value must always be
  /// specified, either directly using this property or using [Directionality].
  final TextDirection? textDirection;

  /// A list of [Shadow]s that will be painted underneath the icon.
  ///
  /// Multiple shadows are supported to replicate lighting from multiple light
  /// sources.
  ///
  /// Shadows must be in the same order for [MIcon] to be considered as
  /// equivalent as order produces differing transparency.
  final List<Shadow>? shadows;

  /// The color to use when drawing the badge.
  ///
  /// {@tool snippet}
  /// Typically, a Material Design color will be used, as follows:
  ///
  /// ```dart
  /// MIcon(
  ///   Icons.leave,
  ///   color: Colors.blue.shade400,
  ///   badgeColor: Colors.red,
  /// )
  /// ```
  /// {@end-tool}
  final Color? badgeColor;

  /// Enable or disable (default) badge.
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// MIcon(
  ///   Icons.leave,
  ///   color: Colors.blue.shade400,
  ///   badge: true,
  /// )
  /// ```
  /// {@end-tool}
  final bool badge;

  @override
  Widget build(BuildContext context) {
    // default size.
    final double iconSize = size ?? 32;

    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (gradientColors == null)
              Icon(
                icon,
                key: key,
                color: color,
                semanticLabel: semanticLabel,
                shadows: shadows,
                size: iconSize,
                textDirection: textDirection,
              ),
            if (gradientColors != null)
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: gradientColors!,
                    tileMode: TileMode.repeated,
                  ).createShader(bounds);
                },
                child: Icon(
                  icon,
                  key: key,
                  semanticLabel: semanticLabel,
                  shadows: shadows,
                  size: iconSize,
                  color: Colors.white,
                  textDirection: textDirection,
                ),
              ),
            Positioned(
              top: iconSize * 0.01,
              right: iconSize * 0.01,
              child: badge
                  ? Container(
                      width: iconSize * 0.5,
                      height: iconSize * 0.4,
                      decoration: BoxDecoration(
                        color: badgeColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
