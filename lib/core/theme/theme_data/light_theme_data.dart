import 'package:flutter/material.dart';
import '../app_colors/custom_app_colors.dart';
import '../app_texts/app_fonts.dart';

ThemeData getLightTheme([BuildContext? context]) {
  final colors = CustomAppColors.light();

  return ThemeData(
    scaffoldBackgroundColor: colors.background,
    brightness: Brightness.light,
    fontFamily: AppFonts.cairo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: colors.primary800,
      brightness: Brightness.light,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: colors.grey900,
      displayColor: colors.grey900,
      fontFamily: AppFonts.cairo,
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: const Color(0xFF1D2952),
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: const TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      headerHelpStyle: const TextStyle(fontFamily: AppFonts.cairo, fontSize: 12),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      todayForegroundColor: WidgetStateProperty.all(const Color(0xFF1D2952)),
      todayBackgroundColor: WidgetStateProperty.all(
        const Color(0xFF1D2952).withValues(alpha: .08),
      ),
      dayStyle: const TextStyle(fontFamily: AppFonts.cairo, fontSize: 13),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return const Color(0xFF1D2952);
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return const Color(0xFF1D2952);
        return Colors.transparent;
      }),
      dayOverlayColor: WidgetStateProperty.all(
        const Color(0xFF1D2952).withValues(alpha: .08),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1D2952),
        textStyle: const TextStyle(fontFamily: AppFonts.cairo, fontSize: 13),
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: const Color(0xFF1D2952),
        textStyle: const TextStyle(
          fontFamily: AppFonts.cairo,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
      weekdayStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 11,
        color: Colors.grey.shade500,
      ),
      yearStyle: const TextStyle(fontFamily: AppFonts.cairo),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return const Color(0xFF1D2952);
      }),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return const Color(0xFF1D2952);
        return Colors.transparent;
      }),
    ),
  );
}
