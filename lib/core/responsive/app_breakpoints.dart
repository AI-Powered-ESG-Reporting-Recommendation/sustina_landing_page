/// Device screen categories supported across the application.
enum DeviceScreenType {
  /// Mobile phones in portrait/landscape or narrow windows (< 600px).
  mobile,

  /// Tablets, foldables, or split-screen windows (600px - 1023px).
  tablet,

  /// Standard desktop, laptops, and medium displays (1024px - 1439px).
  desktop,

  /// Large desktop monitors, ultrawide, and 4K displays (>= 1440px).
  largeDesktop;

  bool get isMobile => this == DeviceScreenType.mobile;
  bool get isTablet => this == DeviceScreenType.tablet;
  bool get isDesktop => this == DeviceScreenType.desktop;
  bool get isLargeDesktop => this == DeviceScreenType.largeDesktop;

  /// True for standard desktop and large desktop displays.
  bool get isDesktopOrLarger =>
      this == DeviceScreenType.desktop || this == DeviceScreenType.largeDesktop;

  /// True for tablet, desktop, and large desktop displays.
  bool get isTabletOrLarger => !isMobile;

  /// True for mobile and tablet displays.
  bool get isMobileOrTablet => isMobile || isTablet;
}

/// Centralized, application-wide responsive breakpoint definitions and layout constraints.
class AppBreakpoints {
  const AppBreakpoints._();

  // Viewport width boundaries (logical pixels)
  static const double mobileMax = 599.0;
  static const double tabletMin = 600.0;
  static const double tabletMax = 1023.0;
  static const double desktopMin = 1024.0;
  static const double largeDesktopMin = 1440.0;

  // Sizing & layout constraints
  static const double maxContentWidth = 1440.0;
  static const double maxFormWidth = 640.0;
  static const double maxDialogWidth = 560.0;
  static const double maxCardWidth = 440.0;

  // Navigation structural dimensions
  static const double sidebarExpandedWidth = 260.0;
  static const double sidebarCollapsedWidth = 76.0;
  static const double navigationRailWidth = 76.0;
  static const double headerHeight = 70.0;

  /// Determines the [DeviceScreenType] for a given pixel [width].
  static DeviceScreenType getDeviceType(double width) {
    if (width >= largeDesktopMin) {
      return DeviceScreenType.largeDesktop;
    } else if (width >= desktopMin) {
      return DeviceScreenType.desktop;
    } else if (width >= tabletMin) {
      return DeviceScreenType.tablet;
    } else {
      return DeviceScreenType.mobile;
    }
  }
}
