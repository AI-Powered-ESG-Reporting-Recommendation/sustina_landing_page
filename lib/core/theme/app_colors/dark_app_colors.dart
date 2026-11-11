import 'package:flutter/material.dart';

class DarkAppColors {
  // ---------- Primary Palette ----------
  static const Color primary900 = Color(0xFFEDF5F1);
  static const Color primary800 = Color(0xFFD9E8E2);
  static const Color primary700 = Color(0xFFA9C8BC);
  static const Color primary600 = Color(0xFF75B5A1);
  static const Color primary500 = Color(0xFF529A85);
  static const Color primary400 = Color(0xFF28715D);
  static const Color primary300 = Color(0xFF174A3C);
  static const Color primary200 = Color(0xFF0F352B);
  static const Color primary100 = Color(0xFF0A241D);

  // ---------- Secondary Palette — Verdia Gold ----------
  static const Color secondary900 = Color(0xFFFBF6E7);
  static const Color secondary800 = Color(0xFFF6EFE3);
  static const Color secondary700 = Color(0xFFECD8B2);
  static const Color secondary600 = Color(0xFFE2C38E);
  static const Color secondary500 = Color(0xFFD4AD6E);
  static const Color secondary400 = Color(0xFFC29859);
  static const Color secondary300 = Color(0xFF9C7942);
  static const Color secondary200 = Color(0xFF6B522E);
  static const Color secondary100 = Color(0xFF292014);

  // ---------- Neutral ----------
  static const Color neutral900 = Color(0xFFF8FAFC);
  static const Color neutral800 = Color(0xFFE2E8F0);
  static const Color neutral700 = Color(0xFFCBD5E1);
  static const Color neutral600 = Color(0xFF94A3B8);
  static const Color neutral500 = Color(0xFF7B8C86);
  static const Color neutral400 = Color(0xFF475569);
  static const Color neutral300 = Color(0xFF334155);
  static const Color neutral200 = Color(0xFF1E293B);
  static const Color neutral100 = Color(0xFF0F172A);

  // ---------- Grey Scale ----------
  static const Color grey900 = Color(0xFFF8FAFC);
  static const Color grey800 = Color(0xFFE2E8F0);
  static const Color grey700 = Color(0xFFCBD5E1);
  static const Color grey600 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF8A9A94);
  static const Color grey400 = Color(0xFF566862);
  static const Color grey300 = Color(0xFF2E3D39);
  static const Color grey200 = Color(0xFF22332F);
  static const Color grey100 = Color(0xFF1A2925);
  static const Color grey50 = Color(0xFF111C19);
  static const Color grey0 = Color(0xFF0B1412);

  // ---------- Surfaces ----------
  static const Color background = Color(0xFF0C1412);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFF15221F);

  // ---------- Status ----------
  static const Color error900 = Color(0xFF5C151B);
  static const Color error700 = Color(0xFFF87171);
  static const Color error500 = Color(0xFFEF4444);

  static const Color warning500 = Color(0xFFF59E0B);

  static const Color info900 = Color(0xFF0D2832);
  static const Color info700 = Color(0xFF5AB8CA);
  static const Color info500 = Color(0xFF4C9AAA);
  static const Color info300 = Color(0xFF163842);

  static const Color accent700 = Color(0xFFD99F47);
  static const Color accent600 = Color(0xFF8E9E97);
  static const Color accent300 = Color(0xFF263833);

  // ---------- Gradients ----------
  static const List<Color> greenGradient = [
    Color(0xFF34D399),
    Color(0xFF10B981),
  ];

  static const List<Color> orangeGradient = [
    Color(0xFFFBBF24),
    Color(0xFFF59E0B),
  ];

  static const List<Color> yellowGradient = [
    Color(0xFFFDE68A),
    Color(0xFFF59E0B),
  ];

  static final List<Color> greenYellowGradient = [
    const Color(0xFF34D399).withValues(alpha: .16),
    const Color(0xFFF59E0B).withValues(alpha: .14),
  ];
}
