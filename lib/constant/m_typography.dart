import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MTypography {
  MTypography._();

  //Heading
  static TextStyle display = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      inherit: false,
    ),
    fontSize: 44,
  );

  //Heading
  static TextStyle heading1 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      inherit: false,
    ),
    fontSize: 28,
  );

  static TextStyle heading2 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      inherit: false,
    ),
    fontSize: 24,
  );

  //Title
  static TextStyle title = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      inherit: false,
    ),
    fontSize: 16,
  );

  //Body
  static TextStyle body1 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w700,
      inherit: false,
    ),
    fontSize: 14,
  );

  static TextStyle body2 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      inherit: false,
    ),
    fontSize: 14,
  );

  static TextStyle body3 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      inherit: false,
    ),
    fontSize: 14,
  );

  //Caption
  static TextStyle caption1 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      inherit: false,
    ),
    fontSize: 12,
  );

  static TextStyle caption2 = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      inherit: false,
    ),
    fontSize: 10,
  );

  //Small
  static TextStyle small = GoogleFonts.rubik(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      inherit: false,
    ),
    fontSize: 12,
  );
}
