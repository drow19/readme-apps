import 'package:book_store_apps/constant/m_colors.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData lightThemeData = themeData(lightColorScheme);
  static ThemeData darkThemeData = themeData(darkColorScheme);

  static ThemeData themeData(ColorScheme colorScheme) {
    return ThemeData(
      platform: TargetPlatform.android,
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: MColors.background,
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(splashFactory: NoSplash.splashFactory),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: MColors.background,
      ),
      dividerTheme: const DividerThemeData(thickness: 0),
    );
  }

  static final lightColorScheme = ColorScheme.fromSeed(
    seedColor: MColors.n6,
    surfaceTint: Colors.transparent,
    primary: MColors.p2,
  );

  static final darkColorScheme = ColorScheme.fromSeed(
    seedColor: MColors.p1,
    brightness: Brightness.dark,
    surfaceTint: Colors.transparent,
    primary: MColors.p2,
  );
}
