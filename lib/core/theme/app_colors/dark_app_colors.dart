import 'package:flutter/material.dart';

class DarkAppColors {
  // ---------- Primary Palette ----------
  static const Color primary100 = Color(0xFF064E3B);
  static const Color primary200 = Color(0xFF047857);
  static const Color primary300 = Color(0xFF059669);
  static const Color primary400 = Color(0xFF10B981);
  static const Color primary500 = Color(0xFF34D399);
  static const Color primary600 = Color(0xFF6EE7B7);
  static const Color primary700 = Color(0xFFA7F3D0);
  static const Color primary800 = Color(0xFFD1FAE5);
  static const Color primary900 = Color(0xFFECFDF5);

  // ---------- Secondary ----------
  static const Color secondary100 = Color(0xFF382B14);
  static const Color secondary200 = Color(0xFF5C4722);
  static const Color secondary300 = Color(0xFF8B6B33);
  static const Color secondary400 = Color(0xFFB88E44);
  static const Color secondary500 = Color(0xFFD4AF37);
  static const Color secondary600 = Color(0xFFE2C264);
  static const Color secondary700 = Color(0xFFEFD692);
  static const Color secondary800 = Color(0xFFF7EAC1);
  static const Color secondary900 = Color(0xFFFBF6E7);

  // ---------- Neutral ----------
  static const Color neutral900 = Color(0xFFF8FAFC);
  static const Color neutral800 = Color(0xFFE2E8F0);
  static const Color neutral700 = Color(0xFFCBD5E1);
  static const Color neutral600 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF64748B);
  static const Color neutral400 = Color(0xFF475569);
  static const Color neutral300 = Color(0xFF334155);
  static const Color neutral200 = Color(0xFF1E293B);
  static const Color neutral100 = Color(0xFF0F172A);

  // ---------- Grey Scale ----------
  static const Color grey900 = Color(0xFFF8FAFC);
  static const Color grey800 = Color(0xFFE2E8F0);
  static const Color grey700 = Color(0xFFCBD5E1);
  static const Color grey600 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey400 = Color(0xFF475569);
  static const Color grey300 = Color(0xFF2E3D39);
  static const Color grey200 = Color(0xFF22332F);
  static const Color grey100 = Color(0xFF1A2925);
  static const Color grey50 = Color(0xFF121E1B);
  static const Color grey0 = Color(0xFF0B1412);

  // ---------- Surfaces ----------
  static const Color background = Color(0xFF0C1412);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFF15221F);

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
