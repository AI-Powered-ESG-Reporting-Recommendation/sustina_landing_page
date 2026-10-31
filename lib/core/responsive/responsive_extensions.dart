import 'package:flutter/widgets.dart';
import 'app_breakpoints.dart';
import 'responsive_helper.dart';
import 'responsive_navigation_support.dart';
import 'responsive_spacing.dart';

/// Convenient responsive extensions on [BuildContext] to simplify layout queries
/// and avoid boilerplate across UI widgets.
extension ResponsiveContextExtension on BuildContext {
  /// The active [DeviceScreenType] of the window.
  DeviceScreenType get deviceScreenType => ResponsiveHelper.getDeviceType(this);

  /// True when viewport width < 600px.
  bool get isMobile => ResponsiveHelper.isMobile(this);

  /// True when 600px <= viewport width < 1024px.
  bool get isTablet => ResponsiveHelper.isTablet(this);

  /// True when 1024px <= viewport width < 1440px.
  bool get isDesktop => ResponsiveHelper.isDesktop(this);

  /// True when viewport width >= 1440px.
  bool get isLargeDesktop => ResponsiveHelper.isLargeDesktop(this);

  /// True when viewport width >= 1024px.
  bool get isDesktopOrLarger => ResponsiveHelper.isDesktopOrLarger(this);

  /// True when viewport width >= 600px.
  bool get isTabletOrLarger => ResponsiveHelper.isTabletOrLarger(this);

  /// True when viewport width < 1024px.
  bool get isMobileOrTablet => isMobile || isTablet;

  /// The width of the viewport in logical pixels.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// The height of the viewport in logical pixels.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// The dimensions of the viewport.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// The orientation of the viewport.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// True if viewport is in landscape orientation.
  bool get isLandscape => orientation == Orientation.landscape;

  /// True if viewport is in portrait orientation.
  bool get isPortrait => orientation == Orientation.portrait;

  /// True if the active directionality is Right-to-Left (e.g. Arabic).
  bool get isRtl => ResponsiveHelper.isRtl(this);

  /// True if the active directionality is Left-to-Right.
  bool get isLtr => !isRtl;

  /// Resolves an adaptive value of type [T] for the current screen size.
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
  }) {
    return ResponsiveHelper.responsiveValue<T>(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Adaptive page padding for the current screen size.
  EdgeInsetsDirectional get responsivePagePadding => ResponsivePadding.page(this);

  /// Recommended navigation layout type for the current screen size.
  NavigationLayoutType get navigationLayoutType =>
      ResponsiveNavigationHelper.getLayoutType(this);

  /// True if a permanent sidebar should be displayed.
  bool get shouldShowPermanentSidebar =>
      ResponsiveNavigationHelper.shouldShowPermanentSidebar(this);

  /// True if a navigation rail should be displayed.
  bool get shouldShowNavigationRail =>
      ResponsiveNavigationHelper.shouldShowNavigationRail(this);

  /// True if an overlay modal drawer or mobile navigation should be used.
  bool get shouldShowModalDrawer =>
      ResponsiveNavigationHelper.shouldShowModalDrawer(this);
}
