import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// Custom scroll behavior tailored for web and desktop viewports.
///
/// Enables drag scrolling using mouse, touch, stylus, and trackpad, ensuring
/// smooth horizontal data table scrolling and list navigation on Flutter Web.
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}
