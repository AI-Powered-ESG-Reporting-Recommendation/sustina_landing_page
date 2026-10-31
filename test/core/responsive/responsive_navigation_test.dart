import 'package:flutter_test/flutter_test.dart';
import 'package:suatina_web_project/core/responsive/app_breakpoints.dart';
import 'package:suatina_web_project/core/responsive/responsive_navigation_support.dart';

void main() {
  group('ResponsiveNavigationHelper.getLayoutTypeFromWidth', () {
    test('returns modalDrawer for widths < 600', () {
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(400),
        NavigationLayoutType.modalDrawer,
      );
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(599),
        NavigationLayoutType.modalDrawer,
      );
    });

    test('returns navigationRail for widths 600 to 1023', () {
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(600),
        NavigationLayoutType.navigationRail,
      );
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(768),
        NavigationLayoutType.navigationRail,
      );
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(1023),
        NavigationLayoutType.navigationRail,
      );
    });

    test('returns permanentSidebar for widths >= 1024', () {
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(1024),
        NavigationLayoutType.permanentSidebar,
      );
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(1440),
        NavigationLayoutType.permanentSidebar,
      );
      expect(
        ResponsiveNavigationHelper.getLayoutTypeFromWidth(1920),
        NavigationLayoutType.permanentSidebar,
      );
    });
  });

  group('SidebarStateController', () {
    test('initializes with expanded state by default', () {
      final controller = SidebarStateController();
      expect(controller.isCollapsed, isFalse);
      expect(controller.currentWidth, AppBreakpoints.sidebarExpandedWidth);
    });

    test('can initialize as collapsed', () {
      final controller = SidebarStateController(initialCollapsed: true);
      expect(controller.isCollapsed, isTrue);
      expect(controller.currentWidth, AppBreakpoints.sidebarCollapsedWidth);
    });

    test('toggle flips collapsed state and notifies listeners', () {
      final controller = SidebarStateController();
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      controller.toggle();
      expect(controller.isCollapsed, isTrue);
      expect(controller.currentWidth, AppBreakpoints.sidebarCollapsedWidth);
      expect(notifyCount, 1);

      controller.toggle();
      expect(controller.isCollapsed, isFalse);
      expect(controller.currentWidth, AppBreakpoints.sidebarExpandedWidth);
      expect(notifyCount, 2);
    });

    test('collapse and expand methods change state conditionally', () {
      final controller = SidebarStateController();
      int notifyCount = 0;
      controller.addListener(() => notifyCount++);

      // already expanded, calling expand should not notify
      controller.expand();
      expect(notifyCount, 0);

      // collapse
      controller.collapse();
      expect(controller.isCollapsed, isTrue);
      expect(notifyCount, 1);

      // already collapsed, calling collapse should not notify
      controller.collapse();
      expect(notifyCount, 1);

      // expand again
      controller.expand();
      expect(controller.isCollapsed, isFalse);
      expect(notifyCount, 2);
    });
  });
}
