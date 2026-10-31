import 'package:flutter/widgets.dart';
import 'app_breakpoints.dart';

/// Encapsulates sizing information for both the global window/screen
/// and the local widget container.
class SizingInformation {
  const SizingInformation({
    required this.deviceScreenType,
    required this.screenSize,
    required this.localWidgetSize,
    required this.constraints,
  });

  /// The screen type determined from local container width.
  final DeviceScreenType deviceScreenType;

  /// The overall device/window screen dimensions.
  final Size screenSize;

  /// The size allocated to this widget by its parent container.
  final Size localWidgetSize;

  /// The raw [BoxConstraints] passed to this widget.
  final BoxConstraints constraints;

  bool get isMobile => deviceScreenType.isMobile;
  bool get isTablet => deviceScreenType.isTablet;
  bool get isDesktop => deviceScreenType.isDesktop;
  bool get isLargeDesktop => deviceScreenType.isLargeDesktop;
  bool get isDesktopOrLarger => deviceScreenType.isDesktopOrLarger;
  bool get isTabletOrLarger => deviceScreenType.isTabletOrLarger;
}

/// A widget builder that supplies comprehensive [SizingInformation] to its child,
/// combining window-level and container-level metrics.
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, SizingInformation sizingInfo) builder;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final sizingInfo = SizingInformation(
          deviceScreenType: AppBreakpoints.getDeviceType(constraints.maxWidth),
          screenSize: mediaQuery.size,
          localWidgetSize: Size(constraints.maxWidth, constraints.maxHeight),
          constraints: constraints,
        );

        return builder(context, sizingInfo);
      },
    );
  }
}
