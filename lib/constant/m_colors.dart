import 'package:flutter/material.dart';

class MColors {
  MColors._(); // this basically makes it so you can't instantiate this class

  /// Primary Colors
  static const p1 = Color(0xFF0D1C4A);
  static const p2 = Color(0xFF395EBC);
  static const p3 = Color(0xFFA8D8F3);

  /// Neutral Colors
  static const n1 = Color(0xFF5C6370);
  static const n2 = Color(0xFF9AA1AC);
  static const n3 = Color(0xFFDDE0E3);
  static const n4 = Color(0xFFF4F5F6);
  static const n5 = Color(0xFFFCFDFF);
  static const n6 = Color(0xFFFFFFFF);

  /// Supplement Colors
  static const blue = Color(0xFF568EF5);
  static const green = Color(0xFF14C0BD);
  static const warning = Color(0xFFFEB719);
  static const orange = Color(0xFFFD9977);
  static const red = Color(0xFFF64E60);
  static const purple = Color(0xFF835DD7);

  // Gradient Colors
  static const blueGradient1 = [p2, p1];
  static const blueGradient2 = [p3, p2];
  static const blueGradient3 = [p3, p2, p1];

  // Background Colors
  static const background = Color(0xFFFCFDFF);
}
