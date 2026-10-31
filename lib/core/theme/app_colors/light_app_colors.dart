import 'package:flutter/material.dart';

class LightAppColors {
  static const Color primary100 = Color(0xFFD9E8E2);
  static const Color primary200 = Color(0xFFA9C8BC);
  static const Color primary300 = Color(0xFF78A99A);
  static const Color primary400 = Color(0xFF43806E);
  static const Color primary500 = Color(0xFF054735);
  static const Color primary600 = Color(0xFF043C2D);
  static const Color primary700 = Color(0xFF033125);
  static const Color primary800 = Color(0xFF02251B);
  static const Color primary900 = Color(0xFF011811);

  // ---------- Secondary Palette — Verdia Gold ----------
  static const Color secondary100 = Color(0xFFF6EFE3);
  static const Color secondary200 = Color(0xFFE8D8BB);
  static const Color secondary300 = Color(0xFFD9C397);
  static const Color secondary400 = Color(0xFFCBAA72);
  static const Color secondary500 = Color(0xFFC29859);
  static const Color secondary600 = Color(0xFFA47D45);
  static const Color secondary700 = Color(0xFF806136);
  static const Color secondary800 = Color(0xFF5B4527);
  static const Color secondary900 = Color(0xFF342818);

  // ---------- Neutral ----------
  static const Color neutral900 = Color(0xFF171B19);
  static const Color neutral800 = Color(0xFF303633);
  static const Color neutral700 = Color(0xFF4B514E);
  static const Color neutral600 = Color(0xFF666D69);
  static const Color neutral500 = Color(0xFF858B88);
  static const Color neutral400 = Color(0xFFA5AAA8);
  static const Color neutral300 = Color(0xFFC7CBC9);
  static const Color neutral200 = Color(0xFFE1E4E2);
  static const Color neutral100 = Color(0xFFFFFFFF);

  // ---------- Grey Scale ----------
  static const Color grey900 = Color(0xFF011811);
  static const Color grey800 = Color(0xFF343B38);
  static const Color grey700 = Color(0xFF555D59);
  static const Color grey600 = Color(0xFF737A77);
  static const Color grey500 = Color(0xFF959B98);
  static const Color grey400 = Color(0xFFB5BAB8);
  static const Color grey300 = Color(0xFFD3D7D5);
  static const Color grey200 = Color(0xFFE8EAE9);
  static const Color grey100 = Color(0xFFF2F4F3);
  static const Color grey50 = Color(0xFFF8F9F8);
  static const Color grey0 = Color(0xFFFFFFFF);

  // ---------- Background ----------
  static const Color background = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // ---------- Status ----------
  static const Color error900 = Color(0xFF8B1E24);
  static const Color error700 = Color(0xFFC9363E);
  static const Color error500 = Color(0xFFE05252);

  static const Color warning500 = Color(0xFFD99A2B);

  static const Color info900 = Color(0xFF174A5B);
  static const Color info700 = Color(0xFF26758A);
  static const Color info500 = Color(0xFF4C9AAA);
  static const Color info300 = Color(0xFF83C1CA);

  // ---------- Accent ----------
  static const Color accent700 = Color(0xFFB07D32);
  static const Color accent600 = Color(0xFF64736C);
  static const Color accent300 = Color(0xFFDDE5E1);

  // ---------- Gradients ----------
  static const List<Color> greenGradient = [
    Color(0xFF10B981),
    Color(0xFF16A34A),
  ];

  static const List<Color> orangeGradient = [
    Color(0xFFF59E0B),
    Color(0xFFEA580C),
  ];

  static const List<Color> yellowGradient = [
    Color(0xFFFCD34D),
    Color(0xFFEAB308),
  ];
  static List<Color> greenYellowGradient = [
    const Color(0xFF10B981).withValues(alpha: .1),
    const Color(0xFFF59E0B).withValues(alpha: .1),
  ];
}
