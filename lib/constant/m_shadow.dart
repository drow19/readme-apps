import 'package:book_store_apps/constant/m_colors.dart';
import 'package:flutter/material.dart';

class MShadow {
  MShadow._();

  static BoxShadow p1Shadow1 = BoxShadow(
    color: MColors.p1.withOpacity(0.12),
    blurRadius: 8,
  );

  static BoxShadow p3Shadow1 = BoxShadow(
    color: MColors.p3.withOpacity(0.3),
    blurRadius: 8,
  );

  static BoxShadow p3Shadow2 = BoxShadow(
    color: MColors.p3.withOpacity(0.5),
    blurRadius: 4,
  );

  static BoxShadow p3Shadow3 = BoxShadow(
    color: MColors.p3.withOpacity(0.5),
    blurRadius: 8,
  );

  static BoxShadow p3Shadow4 = BoxShadow(
    color: MColors.p3.withOpacity(0.5),
    blurRadius: 48,
  );
}