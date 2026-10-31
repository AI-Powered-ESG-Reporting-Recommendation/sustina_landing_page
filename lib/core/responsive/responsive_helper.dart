import 'package:flutter/widgets.dart';
import 'app_breakpoints.dart';

/// Reusable helper methods for detecting viewport characteristics and resolving
/// responsive values based on breakpoints.
class ResponsiveHelper {
  const ResponsiveHelper._();

  /// Returns the current [DeviceScreenType] for the given [context].
  static DeviceScreenType getDeviceType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return AppBreakpoints.getDeviceType(width);
  }

  /// Returns the [DeviceScreenType] for an explicit pixel [width].
  static DeviceScreenType getDeviceTypeFromWidth(double width) {
    return AppBreakpoints.getDeviceType(width);
  }

  /// Whether the current viewport is mobile (< 600px).
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < AppBreakpoints.tabletMin;
  }

  /// Whether the current viewport is tablet (600px - 1023px).
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppBreakpoints.tabletMin && width < AppBreakpoints.desktopMin;
  }

  /// Whether the current viewport is desktop (>= 1024px).
  static bool isDesktop(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppBreakpoints.desktopMin &&
        width < AppBreakpoints.largeDesktopMin;
  }

  /// Whether the current viewport is large desktop (>= 1440px).
  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= AppBreakpoints.largeDesktopMin;
  }

  /// Whether the current viewport is desktop or larger (>= 1024px).
  static bool isDesktopOrLarger(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= AppBreakpoints.desktopMin;
  }

  /// Whether the current viewport is tablet or larger (>= 600px).
  static bool isTabletOrLarger(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= AppBreakpoints.tabletMin;
  }

  /// Whether the current layout is Right-to-Left (e.g., Arabic).
  static bool isRtl(BuildContext context) {
    return Directionality.of(context) == TextDirection.rtl;
  }

  /// Resolves an adaptive value of type [T] based on current viewport width in [context].
  ///
  /// Fallback resolution strategy:
  /// - [largeDesktop] falls back to [desktop] ?? [tablet] ?? [mobile]
  /// - [desktop] falls back to [tablet] ?? [mobile]
  /// - [tablet] falls back to [desktop] ?? [mobile]
  /// - [mobile] uses [mobile]
  static T responsiveValue<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    return responsiveValueFromWidth<T>(
      width,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Resolves an adaptive value of type [T] for an arbitrary pixel [width].
  ///
  /// This is particularly useful inside [LayoutBuilder] constraints where the
  /// parent container's width differs from the overall window width.
  static T responsiveValueFromWidth<T>(
    double width, {
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    final deviceType = AppBreakpoints.getDeviceType(width);

    switch (deviceType) {
      case DeviceScreenType.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile;
      case DeviceScreenType.desktop:
        return desktop ?? tablet ?? mobile;
      case DeviceScreenType.tablet:
        return tablet ?? desktop ?? mobile;
      case DeviceScreenType.mobile:
        return mobile;
    }
  }
}
