import 'package:flutter_test/flutter_test.dart';
import 'package:suatina_web_project/core/responsive/app_breakpoints.dart';
import 'package:suatina_web_project/core/responsive/responsive_helper.dart';

void main() {
  group('ResponsiveHelper.responsiveValueFromWidth', () {
    test('returns exact values when all sizes provided', () {
      const mobileVal = 'mobile';
      const tabletVal = 'tablet';
      const desktopVal = 'desktop';
      const largeVal = 'largeDesktop';

      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          400,
          mobile: mobileVal,
          tablet: tabletVal,
          desktop: desktopVal,
          largeDesktop: largeVal,
        ),
        mobileVal,
      );

      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          800,
          mobile: mobileVal,
          tablet: tabletVal,
          desktop: desktopVal,
          largeDesktop: largeVal,
        ),
        tabletVal,
      );

      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          1200,
          mobile: mobileVal,
          tablet: tabletVal,
          desktop: desktopVal,
          largeDesktop: largeVal,
        ),
        desktopVal,
      );

      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          1600,
          mobile: mobileVal,
          tablet: tabletVal,
          desktop: desktopVal,
          largeDesktop: largeVal,
        ),
        largeVal,
      );
    });

    test('largeDesktop falls back to desktop when largeDesktop is omitted', () {
      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          1600,
          mobile: 'mobile',
          desktop: 'desktop',
        ),
        'desktop',
      );
    });

    test('tablet falls back to desktop when tablet is omitted', () {
      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          800,
          mobile: 'mobile',
          desktop: 'desktop',
        ),
        'desktop',
      );
    });

    test('tablet falls back to mobile when desktop and tablet are omitted', () {
      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          800,
          mobile: 'mobile',
        ),
        'mobile',
      );
    });

    test('desktop falls back to tablet when desktop is omitted', () {
      expect(
        ResponsiveHelper.responsiveValueFromWidth<String>(
          1200,
          mobile: 'mobile',
          tablet: 'tablet',
        ),
        'tablet',
      );
    });
  });

  group('ResponsiveHelper.getDeviceTypeFromWidth', () {
    test('accurately delegates to AppBreakpoints', () {
      expect(
        ResponsiveHelper.getDeviceTypeFromWidth(500),
        DeviceScreenType.mobile,
      );
      expect(
        ResponsiveHelper.getDeviceTypeFromWidth(750),
        DeviceScreenType.tablet,
      );
      expect(
        ResponsiveHelper.getDeviceTypeFromWidth(1100),
        DeviceScreenType.desktop,
      );
      expect(
        ResponsiveHelper.getDeviceTypeFromWidth(1800),
        DeviceScreenType.largeDesktop,
      );
    });
  });
}
