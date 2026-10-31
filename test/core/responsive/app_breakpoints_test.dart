import 'package:flutter_test/flutter_test.dart';
import 'package:suatina_web_project/core/responsive/app_breakpoints.dart';

void main() {
  group('AppBreakpoints.getDeviceType', () {
    test('classifies widths under 600 as mobile', () {
      expect(AppBreakpoints.getDeviceType(0), DeviceScreenType.mobile);
      expect(AppBreakpoints.getDeviceType(375), DeviceScreenType.mobile);
      expect(AppBreakpoints.getDeviceType(599), DeviceScreenType.mobile);
      expect(AppBreakpoints.getDeviceType(599.9), DeviceScreenType.mobile);
    });

    test('classifies widths between 600 and 1023.9 as tablet', () {
      expect(AppBreakpoints.getDeviceType(600), DeviceScreenType.tablet);
      expect(AppBreakpoints.getDeviceType(768), DeviceScreenType.tablet);
      expect(AppBreakpoints.getDeviceType(1023), DeviceScreenType.tablet);
      expect(AppBreakpoints.getDeviceType(1023.9), DeviceScreenType.tablet);
    });

    test('classifies widths between 1024 and 1439.9 as desktop', () {
      expect(AppBreakpoints.getDeviceType(1024), DeviceScreenType.desktop);
      expect(AppBreakpoints.getDeviceType(1280), DeviceScreenType.desktop);
      expect(AppBreakpoints.getDeviceType(1439), DeviceScreenType.desktop);
      expect(AppBreakpoints.getDeviceType(1439.9), DeviceScreenType.desktop);
    });

    test('classifies widths 1440 and above as largeDesktop', () {
      expect(AppBreakpoints.getDeviceType(1440), DeviceScreenType.largeDesktop);
      expect(AppBreakpoints.getDeviceType(1920), DeviceScreenType.largeDesktop);
      expect(AppBreakpoints.getDeviceType(2560), DeviceScreenType.largeDesktop);
      expect(AppBreakpoints.getDeviceType(3840), DeviceScreenType.largeDesktop);
    });
  });

  group('DeviceScreenType getters', () {
    test('mobile getters match expected flags', () {
      const type = DeviceScreenType.mobile;
      expect(type.isMobile, isTrue);
      expect(type.isTablet, isFalse);
      expect(type.isDesktop, isFalse);
      expect(type.isLargeDesktop, isFalse);
      expect(type.isDesktopOrLarger, isFalse);
      expect(type.isTabletOrLarger, isFalse);
      expect(type.isMobileOrTablet, isTrue);
    });

    test('tablet getters match expected flags', () {
      const type = DeviceScreenType.tablet;
      expect(type.isMobile, isFalse);
      expect(type.isTablet, isTrue);
      expect(type.isDesktop, isFalse);
      expect(type.isLargeDesktop, isFalse);
      expect(type.isDesktopOrLarger, isFalse);
      expect(type.isTabletOrLarger, isTrue);
      expect(type.isMobileOrTablet, isTrue);
    });

    test('desktop getters match expected flags', () {
      const type = DeviceScreenType.desktop;
      expect(type.isMobile, isFalse);
      expect(type.isTablet, isFalse);
      expect(type.isDesktop, isTrue);
      expect(type.isLargeDesktop, isFalse);
      expect(type.isDesktopOrLarger, isTrue);
      expect(type.isTabletOrLarger, isTrue);
      expect(type.isMobileOrTablet, isFalse);
    });

    test('largeDesktop getters match expected flags', () {
      const type = DeviceScreenType.largeDesktop;
      expect(type.isMobile, isFalse);
      expect(type.isTablet, isFalse);
      expect(type.isDesktop, isFalse);
      expect(type.isLargeDesktop, isTrue);
      expect(type.isDesktopOrLarger, isTrue);
      expect(type.isTabletOrLarger, isTrue);
      expect(type.isMobileOrTablet, isFalse);
    });
  });

  group('AppBreakpoints sizing constraints', () {
    test('contains expected max width values', () {
      expect(AppBreakpoints.maxContentWidth, 1440.0);
      expect(AppBreakpoints.maxFormWidth, 640.0);
      expect(AppBreakpoints.maxDialogWidth, 560.0);
      expect(AppBreakpoints.sidebarExpandedWidth, 260.0);
      expect(AppBreakpoints.sidebarCollapsedWidth, 76.0);
    });
  });
}
