import 'package:flutter/widgets.dart';
import 'app_breakpoints.dart';
import 'responsive_helper.dart';

/// A layout container that constrains content width on large displays,
/// centers it horizontally, and applies adaptive padding according to viewport size.
///
/// Prevents web content from awkwardly stretching across ultra-wide monitors.
class AdaptiveContentContainer extends StatelessWidget {
  const AdaptiveContentContainer({
    super.key,
    required this.child,
    this.maxWidth = AppBreakpoints.maxContentWidth,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  /// The child widget to be displayed inside the container.
  final Widget child;

  /// Maximum allowed content width. Defaults to [AppBreakpoints.maxContentWidth] (1440px).
  final double maxWidth;

  /// Optional padding override. If null, responsive default padding is applied.
  final EdgeInsetsGeometry? padding;

  /// Alignment of the constrained box within the available space.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ?? _defaultPadding(context);

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: effectivePadding,
          child: child,
        ),
      ),
    );
  }

  EdgeInsetsGeometry _defaultPadding(BuildContext context) {
    final horizontal = ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
      largeDesktop: 40.0,
    );

    final vertical = ResponsiveHelper.responsiveValue<double>(
      context,
      mobile: 16.0,
      tablet: 20.0,
      desktop: 24.0,
      largeDesktop: 32.0,
    );

    return EdgeInsetsDirectional.fromSTEB(horizontal, vertical, horizontal, vertical);
  }
}

/// A specialized constrained container for forms (e.g. login, organization registration,
/// settings forms) ensuring readable, focused form widths across all viewports.
class AdaptiveFormContainer extends StatelessWidget {
  const AdaptiveFormContainer({
    super.key,
    required this.child,
    this.maxWidth = AppBreakpoints.maxFormWidth,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return AdaptiveContentContainer(
      maxWidth: maxWidth,
      padding: padding,
      alignment: Alignment.center,
      child: child,
    );
  }
}
