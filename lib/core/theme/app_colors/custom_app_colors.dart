import 'package:flutter/material.dart';
import 'dark_app_colors.dart';
import 'light_app_colors.dart';

class CustomAppColors {
  const CustomAppColors._({
    // ---------- Primary ----------
    required this.primary100,
    required this.primary200,
    required this.primary300,
    required this.primary400,
    required this.primary500,
    required this.primary600,
    required this.primary700,
    required this.primary800,
    required this.primary900,

    // ---------- Secondary ----------
    required this.secondary100,
    required this.secondary200,
    required this.secondary300,
    required this.secondary400,
    required this.secondary500,
    required this.secondary600,
    required this.secondary700,
    required this.secondary800,
    required this.secondary900,

    // ---------- Neutral ----------
    required this.neutral100,
    required this.neutral200,
    required this.neutral300,
    required this.neutral400,
    required this.neutral500,
    required this.neutral600,
    required this.neutral700,
    required this.neutral800,
    required this.neutral900,

    // ---------- Grey Scale ----------
    required this.grey900,
    required this.grey800,
    required this.grey700,
    required this.grey600,
    required this.grey500,
    required this.grey400,
    required this.grey300,
    required this.grey200,
    required this.grey100,
    required this.grey50,
    required this.grey0,

    // ---------- Base ----------
    required this.background,
    required this.black,
    required this.white,

    // ---------- Status ----------
    required this.error900,
    required this.error700,
    required this.error500,
    required this.warning500,
    required this.info900,
    required this.info700,
    required this.info500,
    required this.info300,

    // ---------- Accent ----------
    required this.accent700,
    required this.accent600,
    required this.accent300,

    // ---------- Gradients ----------
    required this.greenGradient,
    required this.orangeGradient,
    required this.yellowGradient,
    required this.greenYellowGradient,
  });

  // ---------- Primary ----------
  final Color primary100;
  final Color primary200;
  final Color primary300;
  final Color primary400;
  final Color primary500;
  final Color primary600;
  final Color primary700;
  final Color primary800;
  final Color primary900;

  // ---------- Secondary ----------
  final Color secondary100;
  final Color secondary200;
  final Color secondary300;
  final Color secondary400;
  final Color secondary500;
  final Color secondary600;
  final Color secondary700;
  final Color secondary800;
  final Color secondary900;

  // ---------- Neutral ----------
  final Color neutral100;
  final Color neutral200;
  final Color neutral300;
  final Color neutral400;
  final Color neutral500;
  final Color neutral600;
  final Color neutral700;
  final Color neutral800;
  final Color neutral900;

  // ---------- Grey Scale ----------
  final Color grey900;
  final Color grey800;
  final Color grey700;
  final Color grey600;
  final Color grey500;
  final Color grey400;
  final Color grey300;
  final Color grey200;
  final Color grey100;
  final Color grey50;
  final Color grey0;

  // ---------- Base ----------
  final Color background;
  final Color black;
  final Color white;

  // ---------- Status ----------
  final Color error900;
  final Color error700;
  final Color error500;
  final Color warning500;
  final Color info900;
  final Color info700;
  final Color info500;
  final Color info300;

  // ---------- Accent ----------
  final Color accent700;
  final Color accent600;
  final Color accent300;

  // ---------- Gradients ----------
  final List<Color> greenGradient;
  final List<Color> orangeGradient;
  final List<Color> yellowGradient;
  final List<Color> greenYellowGradient;

  // ---------- Light Theme ----------
  factory CustomAppColors.light() {
    return CustomAppColors._(
      // Primary
      primary100: LightAppColors.primary100,
      primary200: LightAppColors.primary200,
      primary300: LightAppColors.primary300,
      primary400: LightAppColors.primary400,
      primary500: LightAppColors.primary500,
      primary600: LightAppColors.primary600,
      primary700: LightAppColors.primary700,
      primary800: LightAppColors.primary800,
      primary900: LightAppColors.primary900,

      // Secondary
      secondary100: LightAppColors.secondary100,
      secondary200: LightAppColors.secondary200,
      secondary300: LightAppColors.secondary300,
      secondary400: LightAppColors.secondary400,
      secondary500: LightAppColors.secondary500,
      secondary600: LightAppColors.secondary600,
      secondary700: LightAppColors.secondary700,
      secondary800: LightAppColors.secondary800,
      secondary900: LightAppColors.secondary900,

      // Neutral
      neutral100: LightAppColors.neutral100,
      neutral200: LightAppColors.neutral200,
      neutral300: LightAppColors.neutral300,
      neutral400: LightAppColors.neutral400,
      neutral500: LightAppColors.neutral500,
      neutral600: LightAppColors.neutral600,
      neutral700: LightAppColors.neutral700,
      neutral800: LightAppColors.neutral800,
      neutral900: LightAppColors.neutral900,

      // Grey
      grey900: LightAppColors.grey900,
      grey800: LightAppColors.grey800,
      grey700: LightAppColors.grey700,
      grey600: LightAppColors.grey600,
      grey500: LightAppColors.grey500,
      grey400: LightAppColors.grey400,
      grey300: LightAppColors.grey300,
      grey200: LightAppColors.grey200,
      grey100: LightAppColors.grey100,
      grey50: LightAppColors.grey50,
      grey0: LightAppColors.grey0,

      // Base
      background: LightAppColors.background,
      black: LightAppColors.black,
      white: LightAppColors.white,

      // Status
      error900: LightAppColors.error900,
      error700: LightAppColors.error700,
      error500: LightAppColors.error500,
      warning500: LightAppColors.warning500,
      info900: LightAppColors.info900,
      info700: LightAppColors.info700,
      info500: LightAppColors.info500,
      info300: LightAppColors.info300,

      // Accent
      accent700: LightAppColors.accent700,
      accent600: LightAppColors.accent600,
      accent300: LightAppColors.accent300,

      // Gradients
      greenGradient: LightAppColors.greenGradient,
      orangeGradient: LightAppColors.orangeGradient,
      yellowGradient: LightAppColors.yellowGradient,
      greenYellowGradient: LightAppColors.greenYellowGradient,
    );
  }

  // ---------- Dark Theme ----------
  factory CustomAppColors.dark() {
    return CustomAppColors._(
      primary100: DarkAppColors.primary100,
      primary200: DarkAppColors.primary200,
      primary300: DarkAppColors.primary300,
      primary400: DarkAppColors.primary400,
      primary500: DarkAppColors.primary500,
      primary600: DarkAppColors.primary600,
      primary700: DarkAppColors.primary700,
      primary800: DarkAppColors.primary800,
      primary900: DarkAppColors.primary900,

      secondary100: DarkAppColors.secondary100,
      secondary200: DarkAppColors.secondary200,
      secondary300: DarkAppColors.secondary300,
      secondary400: DarkAppColors.secondary400,
      secondary500: DarkAppColors.secondary500,
      secondary600: DarkAppColors.secondary600,
      secondary700: DarkAppColors.secondary700,
      secondary800: DarkAppColors.secondary800,
      secondary900: DarkAppColors.secondary900,

      neutral100: DarkAppColors.neutral100,
      neutral200: DarkAppColors.neutral200,
      neutral300: DarkAppColors.neutral300,
      neutral400: DarkAppColors.neutral400,
      neutral500: DarkAppColors.neutral500,
      neutral600: DarkAppColors.neutral600,
      neutral700: DarkAppColors.neutral700,
      neutral800: DarkAppColors.neutral800,
      neutral900: DarkAppColors.neutral900,

      grey900: DarkAppColors.grey900,
      grey800: DarkAppColors.grey800,
      grey700: DarkAppColors.grey700,
      grey600: DarkAppColors.grey600,
      grey500: DarkAppColors.grey500,
      grey400: DarkAppColors.grey400,
      grey300: DarkAppColors.grey300,
      grey200: DarkAppColors.grey200,
      grey100: DarkAppColors.grey100,
      grey50: DarkAppColors.grey50,
      grey0: DarkAppColors.grey0,

      background: DarkAppColors.background,
      black: DarkAppColors.black,
      white: DarkAppColors.white,

      error900: DarkAppColors.error900,
      error700: DarkAppColors.error700,
      error500: DarkAppColors.error500,
      warning500: DarkAppColors.warning500,
      info900: DarkAppColors.info900,
      info700: DarkAppColors.info700,
      info500: DarkAppColors.info500,
      info300: DarkAppColors.info300,

      accent700: DarkAppColors.accent700,
      accent600: DarkAppColors.accent600,
      accent300: DarkAppColors.accent300,

      greenGradient: DarkAppColors.greenGradient,
      orangeGradient: DarkAppColors.orangeGradient,
      yellowGradient: DarkAppColors.yellowGradient,
      greenYellowGradient: DarkAppColors.greenYellowGradient,
    );
  }

  static CustomAppColors of(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? CustomAppColors.dark()
        : CustomAppColors.light();
  }
}
