import 'package:flutter/widgets.dart';
import 'app_breakpoints.dart';

/// The structural layout mode that navigation components should assume
/// for a given viewport width.
enum NavigationLayoutType {
  /// Permanent sidebar rendered alongside page content (Desktop >= 1024px).
  permanentSidebar,

  /// Compact navigation rail or collapsible slim sidebar (Tablet 600px - 1023px).
  navigationRail,

  /// Hidden overlay drawer or bottom navigation (Mobile < 600px).
  modalDrawer;

  bool get isPermanentSidebar => this == NavigationLayoutType.permanentSidebar;
  bool get isNavigationRail => this == NavigationLayoutType.navigationRail;
  bool get isModalDrawer => this == NavigationLayoutType.modalDrawer;
}

/// Utility for determining the appropriate navigation layout behavior
/// based on responsive breakpoints.
class ResponsiveNavigationHelper {
  const ResponsiveNavigationHelper._();

  /// Returns the recommended [NavigationLayoutType] for the given [context].
  static NavigationLayoutType getLayoutType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return getLayoutTypeFromWidth(width);
  }

  /// Returns the recommended [NavigationLayoutType] for an explicit pixel [width].
  static NavigationLayoutType getLayoutTypeFromWidth(double width) {
    if (width >= AppBreakpoints.desktopMin) {
      return NavigationLayoutType.permanentSidebar;
    } else if (width >= AppBreakpoints.tabletMin) {
      return NavigationLayoutType.navigationRail;
    } else {
      return NavigationLayoutType.modalDrawer;
    }
  }

  /// True when the viewport should show a permanent sidebar (>= 1024px).
  static bool shouldShowPermanentSidebar(BuildContext context) {
    return getLayoutType(context) == NavigationLayoutType.permanentSidebar;
  }

  /// True when the viewport should show a navigation rail (600px - 1023px).
  static bool shouldShowNavigationRail(BuildContext context) {
    return getLayoutType(context) == NavigationLayoutType.navigationRail;
  }

  /// True when the viewport should use an overlay drawer or mobile navigation (< 600px).
  static bool shouldShowModalDrawer(BuildContext context) {
    return getLayoutType(context) == NavigationLayoutType.modalDrawer;
  }
}

/// State controller for expandable/collapsible sidebar navigation.
///
/// Provides reactive state for sidebar expansion without implementing UI.
class SidebarStateController extends ChangeNotifier {
  SidebarStateController({bool initialCollapsed = false})
      : _isCollapsed = initialCollapsed;

  bool _isCollapsed;

  /// Whether the sidebar is currently in its collapsed (icon-only) state.
  bool get isCollapsed => _isCollapsed;

  /// The active width for the sidebar based on its collapsed state.
  double get currentWidth => _isCollapsed
      ? AppBreakpoints.sidebarCollapsedWidth
      : AppBreakpoints.sidebarExpandedWidth;

  /// Toggles the collapsed state and notifies listeners.
  void toggle() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }

  /// Collapses the sidebar to its compact width.
  void collapse() {
    if (!_isCollapsed) {
      _isCollapsed = true;
      notifyListeners();
    }
  }

  /// Expands the sidebar to its full width.
  void expand() {
    if (_isCollapsed) {
      _isCollapsed = false;
      notifyListeners();
    }
  }
}
