// App bars are typically used in the [Scaffold.appBar] property, which places
import 'package:book_store_apps/constant/m_colors.dart';
import 'package:book_store_apps/constant/m_typography.dart';
import 'package:book_store_apps/widgets/icon/m_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// the app bar at the top of the screen. For a scrollable
/// app bar, see [SliverAppBar], which embeds an [AppBar] in a sliver for use in
/// a [CustomScrollView].
///
/// The AppBar displays the toolbar widgets, [leading], [title], and [action],
///
/// ![The leading widget is in the top left, the actions are in the top right,
/// the title is between them.
///
/// If the [leading] widget is omitted, a back button is inserted instead.
class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A widget to display before the toolbar's [title].
  ///
  /// The leading can be null,in which case the widget will render back button.
  final IconButton? leading;

  /// The primary widget displayed in the app bar.
  final String title;

  /// A widget to display after the toolbar's [title].
  ///
  /// /// The icon can be null, in which case the widget will render as an empty
  final Widget? action;

  /// {@template flutter.material.appbar.automaticallyImplyLeading}
  /// Controls whether we should try to imply the leading widget if null.
  ///
  /// If true and [leading] is null, automatically try to deduce what the leading
  /// widget should be. If false and [leading] is null, leading space is given to [title].
  /// If leading widget is not null, this parameter has no effect.
  /// {@endtemplate}
  final bool automaticallyImplyLeading;

  /// The color to use when drawing the title.
  final Color? titleColor;

  /// The color to use when drawing the icon.
  final Color? iconColor;

  /// The fill color to use for an app bar's [Material].
  final Color? backgroundColor;

  /// Background image on appbar
  final Widget? flexibleSpace;

  /// The brightness of top status bar.
  final Brightness? brightness;

  const MAppBar({
    required this.title,
    super.key,
    this.leading,
    this.action,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.flexibleSpace,
    this.brightness = Brightness.light,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: brightness),
      shadowColor: Colors.transparent,
      toolbarHeight: 50.0,
      leadingWidth: 48,
      leading: leading ??
          (automaticallyImplyLeading ? _buildDefaultLeading(context) : null),
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Text(
        title,
        style: MTypography.title.copyWith(color: titleColor ?? MColors.p1),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? MColors.background,
      iconTheme: IconThemeData(
        color: iconColor ?? MColors.p1,
      ),
      actions: <Widget>[if (action != null) action!],
      flexibleSpace: flexibleSpace,
    );
  }

  IconButton _buildDefaultLeading(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      icon: const MIcon(
        Icons.arrow_back,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
