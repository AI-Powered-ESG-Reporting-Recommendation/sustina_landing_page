import 'package:flutter/material.dart';

class DarkAppColors {
  // ---------- Primary Palette ----------
  static const Color primary100 = Color(0xFFD7E5F4);
  static const Color primary200 = Color(0xFFAECBEA);
  static const Color primary300 = Color(0xFF86B1DF);
  static const Color primary400 = Color(0xFF5E97D4);
  static const Color primary500 = Color(0xFF285E98);
  static const Color primary600 = Color(0xFF2B64A1);
  static const Color primary700 = Color(0xFF204B79);
  static const Color primary800 = Color(0xFF153251);
  static const Color primary900 = Color(0xFF0B1928);

  // ---------- Secondary ----------
  static const Color secondary100 = Color(0xFFEDE9DE);
  static const Color secondary200 = Color(0xFFD8D2BD);
  static const Color secondary300 = Color(0xFFC8BC9D);
  static const Color secondary400 = Color(0xFFB6A67C);
  static const Color secondary500 = Color(0xFFCDC2A5);
  static const Color secondary600 = Color(0xFF837349);
  static const Color secondary700 = Color(0xFF625837);
  static const Color secondary800 = Color(0xFF423924);
  static const Color secondary900 = Color(0xFF211D12);

  // ---------- Neutral ----------
  static const Color neutral900 = Color(0xFF1A1A1A);
  static const Color neutral800 = Color(0xFF333333);
  static const Color neutral700 = Color(0xFF4D4D4D);
  static const Color neutral600 = Color(0xFF666666);
  static const Color neutral500 = Color(0xFF999999);
  static const Color neutral400 = Color(0xFFB3B3B3);
  static const Color neutral300 = Color(0xFFCCCCCC);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral100 = Color(0xFFFFFFFF);

  // ---------- Grey Scale ----------
  static const Color grey900 = Color(0xFF011308);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey100 = Color(0xFFDFE1E7);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey0 = Color(0xFFFFFFFF);

  // ---------- Neutral ----------
  static const Color background = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  // ---------- Status ----------
  static const Color error900 = Color(0xFF93000A);
  static const Color error700 = Color(0xFFDF1C41);
  static const Color error500 = Color(0xFFEF4444);

  static const Color warning500 = Color(0xFFF59E0B);

  static const Color info900 = Color(0xFF1E40AF);
  static const Color info700 = Color(0xFF2563EB);

  static const Color info500 = Color(0xFF6B21A8);
  static const Color info300 = Color(0xFF8B5CF6);

  static const Color accent700 = Color(0xFFEA580C);
  static const Color accent600 = Color(0xFF4B5563);
  static const Color accent300 = Color(0xFFE5E7EB);

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
