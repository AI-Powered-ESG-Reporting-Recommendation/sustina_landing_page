import 'package:flutter/material.dart';

import '../app_texts/app_fonts.dart';
import '../theme_manager/theme_extensions.dart';

ThemeData getLightTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: context.customAppColors.background,
    brightness: Brightness.light,
    fontFamily: AppFonts.cairo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: context.customAppColors.primary800,
      brightness: Brightness.light,
    ),
    textTheme: ThemeData.light().textTheme.apply(
      bodyColor: context.customAppColors.grey900,
      displayColor: context.customAppColors.grey900,
      fontFamily: AppFonts.cairo,
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: Color(0xFF1D2952),
      headerForegroundColor: Colors.white,
      headerHeadlineStyle: TextStyle(
        fontFamily: AppFonts.cairo,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      headerHelpStyle: TextStyle(fontFamily: AppFonts.cairo, fontSize: 12),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      todayForegroundColor: WidgetStateProperty.all(Color(0xFF1D2952)),
      todayBackgroundColor: WidgetStateProperty.all(
        Color(0xFF1D2952).withValues(alpha: .08),
      ),
      dayStyle: TextStyle(fontFamily: AppFonts.cairo, fontSize: 13),
      dayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return Color(0xFF1D2952);
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Color(0xFF1D2952);
        return Colors.transparent;
      }),
      dayOverlayColor: WidgetStateProperty.all(
        Color(0xFF1D2952).withValues(alpha: .08),
      ),
      cancelButtonStyle: TextButton.styleFrom(
        foregroundColor: Color(0xFF1D2952),
        textStyle: TextStyle(fontFamily: AppFonts.cairo, fontSize: 13),
      ),
      confirmButtonStyle: TextButton.styleFrom(
        foregroundColor: Color(0xFF1D2952),
        textStyle: TextStyle(
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
      yearStyle: TextStyle(fontFamily: AppFonts.cairo),
      yearForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Colors.white;
        return Color(0xFF1D2952);
      }),
      yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return Color(0xFF1D2952);
        return Colors.transparent;
      }),
    ),
  );
}
