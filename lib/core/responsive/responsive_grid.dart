import 'package:flutter/widgets.dart';
import 'responsive_helper.dart';
import 'responsive_spacing.dart';

/// Reusable helper for computing grid columns and responsive dimensions across features.
class ResponsiveGridHelper {
  const ResponsiveGridHelper._();

  /// Calculates the recommended column count for a given pixel [width].
  static int columnsForWidth(
    double width, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
    int largeDesktop = 4,
  }) {
    return ResponsiveHelper.responsiveValueFromWidth<int>(
      width,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Calculates the recommended column count for the given [context].
  static int columnsForContext(
    BuildContext context, {
    int mobile = 1,
    int tablet = 2,
    int desktop = 3,
    int largeDesktop = 4,
  }) {
    final width = MediaQuery.sizeOf(context).width;
    return columnsForWidth(
      width,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
    );
  }

  /// Calculates item width when laying out [columns] items across [totalWidth] with [spacing].
  static double itemWidthForColumns({
    required double totalWidth,
    required int columns,
    required double spacing,
  }) {
    if (columns <= 1) return totalWidth;
    final totalSpacing = spacing * (columns - 1);
    final available = totalWidth - totalSpacing;
    return (available / columns).clamp(0.0, double.infinity);
  }
}

/// A responsive [Wrap] layout that automatically uses responsive gutter spacing
/// between children.
class ResponsiveWrap extends StatelessWidget {
  const ResponsiveWrap({
    super.key,
    required this.children,
    this.spacing,
    this.runSpacing,
    this.alignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
  });

  final List<Widget> children;
  final double? spacing;
  final double? runSpacing;
  final WrapAlignment alignment;
  final WrapCrossAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final gutter = ResponsiveGap.gutter(context);

    return Wrap(
      spacing: spacing ?? gutter,
      runSpacing: runSpacing ?? gutter,
      alignment: alignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
