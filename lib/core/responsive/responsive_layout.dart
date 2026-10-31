import 'package:flutter/widgets.dart';
import 'app_breakpoints.dart';

/// A screen-level responsive layout widget that renders different layouts based
/// on the active [DeviceScreenType] of the window/screen.
///
/// Features can define distinct layouts for mobile, tablet, desktop, and large desktop
/// without reinventing breakpoint detection or hardcoding pixel checks.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  /// The builder used for mobile screens (< 600px).
  final WidgetBuilder mobile;

  /// Optional builder for tablet screens (600px - 1023px).
  /// Falls back to [desktop] ?? [mobile] if not provided.
  final WidgetBuilder? tablet;

  /// Optional builder for standard desktop screens (1024px - 1439px).
  /// Falls back to [tablet] ?? [mobile] if not provided.
  final WidgetBuilder? desktop;

  /// Optional builder for large desktop screens (>= 1440px).
  /// Falls back to [desktop] ?? [tablet] ?? [mobile] if not provided.
  final WidgetBuilder? largeDesktop;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final deviceType = AppBreakpoints.getDeviceType(width);

    switch (deviceType) {
      case DeviceScreenType.largeDesktop:
        if (largeDesktop != null) return largeDesktop!(context);
        if (desktop != null) return desktop!(context);
        if (tablet != null) return tablet!(context);
        return mobile(context);

      case DeviceScreenType.desktop:
        if (desktop != null) return desktop!(context);
        if (tablet != null) return tablet!(context);
        return mobile(context);

      case DeviceScreenType.tablet:
        if (tablet != null) return tablet!(context);
        if (desktop != null) return desktop!(context);
        return mobile(context);

      case DeviceScreenType.mobile:
        return mobile(context);
    }
  }
}

/// A component-level responsive layout widget that adapts according to the
/// [BoxConstraints.maxWidth] of its immediate parent container rather than the
/// global screen width.
///
/// This is essential in web applications where cards, split panes, or grid cells
/// need to adapt their internal layout based on their allocated container space.
class ResponsiveContainerLayout extends StatelessWidget {
  const ResponsiveContainerLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
  });

  final Widget Function(BuildContext context, BoxConstraints constraints) mobile;
  final Widget Function(BuildContext context, BoxConstraints constraints)? tablet;
  final Widget Function(BuildContext context, BoxConstraints constraints)? desktop;
  final Widget Function(BuildContext context, BoxConstraints constraints)? largeDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = AppBreakpoints.getDeviceType(constraints.maxWidth);

        switch (deviceType) {
          case DeviceScreenType.largeDesktop:
            if (largeDesktop != null) return largeDesktop!(context, constraints);
            if (desktop != null) return desktop!(context, constraints);
            if (tablet != null) return tablet!(context, constraints);
            return mobile(context, constraints);

          case DeviceScreenType.desktop:
            if (desktop != null) return desktop!(context, constraints);
            if (tablet != null) return tablet!(context, constraints);
            return mobile(context, constraints);

          case DeviceScreenType.tablet:
            if (tablet != null) return tablet!(context, constraints);
            if (desktop != null) return desktop!(context, constraints);
            return mobile(context, constraints);

          case DeviceScreenType.mobile:
            return mobile(context, constraints);
        }
      },
    );
  }
}
