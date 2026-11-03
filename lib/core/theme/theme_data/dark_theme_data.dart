import 'package:flutter/material.dart';
import '../app_colors/custom_app_colors.dart';
import '../app_texts/app_fonts.dart';

ThemeData getDarkTheme([BuildContext? context]) {
  final colors = CustomAppColors.dark();

  return ThemeData(
    scaffoldBackgroundColor: colors.background,
    brightness: Brightness.dark,
    fontFamily: AppFonts.cairo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primary500,
      brightness: Brightness.dark,
      surface: colors.white,
    ),
    cardTheme: CardThemeData(
      color: colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.grey200),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: colors.grey200,
      thickness: 1,
    ),
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: colors.neutral900,
      displayColor: colors.neutral900,
      fontFamily: AppFonts.cairo,
    ),
  );
}
