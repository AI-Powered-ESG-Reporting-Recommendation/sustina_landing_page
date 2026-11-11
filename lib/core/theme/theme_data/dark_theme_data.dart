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
      primary: colors.primary500,
      secondary: colors.secondary500,
      surface: colors.white,
      error: colors.error700,
    ),
    cardTheme: CardThemeData(
      color: colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: colors.grey200),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: colors.white,
      surfaceTintColor: colors.white.withValues(alpha: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.grey200),
      ),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: colors.neutral900,
      ),
      contentTextStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 14,
        color: colors.neutral700,
        height: 1.6,
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
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: colors.primary200,
      headerForegroundColor: colors.neutral900,
      headerHeadlineStyle: const TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 26,
        fontWeight: FontWeight.w600,
      ),
      headerHelpStyle: const TextStyle(fontFamily: AppFonts.cairo, fontSize: 12),
      backgroundColor: colors.white,
      surfaceTintColor: colors.white.withValues(alpha: 0),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.grey200),
      ),
      todayForegroundColor: WidgetStateProperty.all(colors.primary700),
      todayBackgroundColor: WidgetStateProperty.all(colors.primary100),
      dayStyle: const TextStyle(fontFamily: AppFonts.cairo, fontSize: 13),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.grey0;
        if (states.contains(WidgetState.disabled)) return colors.grey400;
        return colors.neutral900;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.primary600;
        return colors.white.withValues(alpha: 0);
      }),
      dayOverlayColor: WidgetStateProperty.all(
        colors.primary500.withValues(alpha: 0.18),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: colors.neutral700,
        textStyle: const TextStyle(fontFamily: AppFonts.cairo, fontSize: 13),
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: colors.primary700,
        textStyle: const TextStyle(
          fontFamily: AppFonts.cairo,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
      weekdayStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 11,
        color: colors.grey600,
      ),
      yearStyle: const TextStyle(fontFamily: AppFonts.cairo),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.grey0;
        return colors.neutral900;
      }),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return colors.primary600;
        return colors.white.withValues(alpha: 0);
      }),
    ),
  );
}
