import 'package:flutter/widgets.dart';
import 'responsive_helper.dart';

/// Centralized layout spacing tokens for margin, padding, and gaps.
class AppSpacing {
  const AppSpacing._();

  static const double none = 0.0;
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

/// Adaptive padding utilities that resolve padding dimensions according to screen size
/// while strictly honoring text direction (RTL / LTR).
class ResponsivePadding {
  const ResponsivePadding._();

  /// Adaptive horizontal page padding: 16px (mobile), 24px (tablet), 32px (desktop), 40px (large desktop).
  static double pageHorizontal(BuildContext context) {
    return ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: AppSpacing.md,
      tablet: AppSpacing.lg,
      desktop: AppSpacing.xl,
      largeDesktop: 40.0,
    );
  }

  /// Adaptive vertical page padding: 16px (mobile), 20px (tablet), 24px (desktop), 32px (large desktop).
  static double pageVertical(BuildContext context) {
    return ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: AppSpacing.md,
      tablet: 20.0,
      desktop: AppSpacing.lg,
      largeDesktop: AppSpacing.xl,
    );
  }

  /// Adaptive full page padding returning [EdgeInsetsDirectional] for RTL support.
  static EdgeInsetsDirectional page(BuildContext context) {
    final h = pageHorizontal(context);
    final v = pageVertical(context);
    return EdgeInsetsDirectional.fromSTEB(h, v, h, v);
  }

  /// Adaptive card internal padding: 12px (mobile), 16px (tablet), 20px (desktop).
  static EdgeInsetsDirectional card(BuildContext context) {
    final p = ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: 12.0,
      tablet: AppSpacing.md,
      desktop: 20.0,
      largeDesktop: AppSpacing.lg,
    );
    return EdgeInsetsDirectional.all(p);
  }

  /// Adaptive dialog internal padding: 16px (mobile), 24px (tablet/desktop).
  static EdgeInsetsDirectional dialog(BuildContext context) {
    final p = ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: AppSpacing.md,
      tablet: AppSpacing.lg,
      desktop: AppSpacing.lg,
    );
    return EdgeInsetsDirectional.all(p);
  }
}

/// Adaptive layout gutter and section gaps between elements.
class ResponsiveGap {
  const ResponsiveGap._();

  /// Gutter between columns/cards: 12px (mobile), 16px (tablet), 24px (desktop).
  static double gutter(BuildContext context) {
    return ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: 12.0,
      tablet: AppSpacing.md,
      desktop: AppSpacing.lg,
    );
  }

  /// Spacing between major vertical page sections: 16px (mobile), 24px (tablet), 32px (desktop).
  static double section(BuildContext context) {
    return ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: AppSpacing.md,
      tablet: AppSpacing.lg,
      desktop: AppSpacing.xl,
      largeDesktop: AppSpacing.xxl,
    );
  }
}
