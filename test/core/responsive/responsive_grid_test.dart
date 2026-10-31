import 'package:flutter_test/flutter_test.dart';
import 'package:suatina_web_project/core/responsive/responsive_grid.dart';

void main() {
  group('ResponsiveGridHelper.columnsForWidth', () {
    test('uses defaults: 1 col on mobile, 2 on tablet, 3 on desktop, 4 on largeDesktop', () {
      expect(ResponsiveGridHelper.columnsForWidth(400), 1);
      expect(ResponsiveGridHelper.columnsForWidth(768), 2);
      expect(ResponsiveGridHelper.columnsForWidth(1200), 3);
      expect(ResponsiveGridHelper.columnsForWidth(1600), 4);
    });

    test('supports custom column counts', () {
      expect(
        ResponsiveGridHelper.columnsForWidth(
          400,
          mobile: 1,
          tablet: 3,
          desktop: 6,
          largeDesktop: 12,
        ),
        1,
      );
      expect(
        ResponsiveGridHelper.columnsForWidth(
          768,
          mobile: 1,
          tablet: 3,
          desktop: 6,
          largeDesktop: 12,
        ),
        3,
      );
      expect(
        ResponsiveGridHelper.columnsForWidth(
          1200,
          mobile: 1,
          tablet: 3,
          desktop: 6,
          largeDesktop: 12,
        ),
        6,
      );
      expect(
        ResponsiveGridHelper.columnsForWidth(
          1600,
          mobile: 1,
          tablet: 3,
          desktop: 6,
          largeDesktop: 12,
        ),
        12,
      );
    });
  });

  group('ResponsiveGridHelper.itemWidthForColumns', () {
    test('1 column uses full width', () {
      expect(
        ResponsiveGridHelper.itemWidthForColumns(
          totalWidth: 1000,
          columns: 1,
          spacing: 16,
        ),
        1000.0,
      );
    });

    test('2 columns with 16px spacing divides remaining width equally', () {
      // 1000 total - 16 gap = 984 / 2 = 492
      expect(
        ResponsiveGridHelper.itemWidthForColumns(
          totalWidth: 1000,
          columns: 2,
          spacing: 16,
        ),
        492.0,
      );
    });

    test('3 columns with 20px spacing', () {
      // 1000 total - 40 gap = 960 / 3 = 320
      expect(
        ResponsiveGridHelper.itemWidthForColumns(
          totalWidth: 1000,
          columns: 3,
          spacing: 20,
        ),
        320.0,
      );
    });
  });
}
