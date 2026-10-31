import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';

Widget _buildTestApp({required Widget child}) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

void main() {
  group('ResponsiveLayout', () {
    testWidgets('renders mobile layout on narrow screens', (tester) async {
      tester.view.physicalSize = const Size(450, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestApp(
          child: ResponsiveLayout(
            mobile: (context) => const Text('Mobile Layout'),
            tablet: (context) => const Text('Tablet Layout'),
            desktop: (context) => const Text('Desktop Layout'),
          ),
        ),
      );

      expect(find.text('Mobile Layout'), findsOneWidget);
      expect(find.text('Tablet Layout'), findsNothing);
      expect(find.text('Desktop Layout'), findsNothing);
    });

    testWidgets('renders tablet layout on medium screens', (tester) async {
      tester.view.physicalSize = const Size(800, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestApp(
          child: ResponsiveLayout(
            mobile: (context) => const Text('Mobile Layout'),
            tablet: (context) => const Text('Tablet Layout'),
            desktop: (context) => const Text('Desktop Layout'),
          ),
        ),
      );

      expect(find.text('Tablet Layout'), findsOneWidget);
      expect(find.text('Mobile Layout'), findsNothing);
    });

    testWidgets('renders desktop layout on wide screens', (tester) async {
      tester.view.physicalSize = const Size(1200, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestApp(
          child: ResponsiveLayout(
            mobile: (context) => const Text('Mobile Layout'),
            tablet: (context) => const Text('Tablet Layout'),
            desktop: (context) => const Text('Desktop Layout'),
          ),
        ),
      );

      expect(find.text('Desktop Layout'), findsOneWidget);
      expect(find.text('Mobile Layout'), findsNothing);
    });

    testWidgets('tablet falls back to desktop if tablet is null', (tester) async {
      tester.view.physicalSize = const Size(800, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestApp(
          child: ResponsiveLayout(
            mobile: (context) => const Text('Mobile Layout'),
            desktop: (context) => const Text('Desktop Layout'),
          ),
        ),
      );

      expect(find.text('Desktop Layout'), findsOneWidget);
    });
  });

  group('ResponsiveContainerLayout', () {
    testWidgets('adapts based on parent container constraints', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 500,
              child: ResponsiveContainerLayout(
                mobile: (context, constraints) => const Text('Container Mobile'),
                desktop: (context, constraints) => const Text('Container Desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Container Mobile'), findsOneWidget);
      expect(find.text('Container Desktop'), findsNothing);
    });

    testWidgets('renders desktop in wide container', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 1200,
              child: ResponsiveContainerLayout(
                mobile: (context, constraints) => const Text('Container Mobile'),
                desktop: (context, constraints) => const Text('Container Desktop'),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Container Desktop'), findsOneWidget);
      expect(find.text('Container Mobile'), findsNothing);
    });
  });

  group('AdaptiveContentContainer', () {
    testWidgets('constrains child width to maxWidth on wider viewports', (tester) async {
      tester.view.physicalSize = const Size(2000, 1000);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(
        _buildTestApp(
          child: const AdaptiveContentContainer(
            maxWidth: 1000,
            padding: EdgeInsets.zero,
            child: SizedBox(
              key: Key('inner_box'),
              width: double.infinity,
              height: 200,
            ),
          ),
        ),
      );

      final boxFinder = find.byKey(const Key('inner_box'));
      expect(boxFinder, findsOneWidget);
      final size = tester.getSize(boxFinder);
      expect(size.width, 1000.0);
    });
  });

  group('ResponsiveBuilder', () {
    testWidgets('supplies sizing information correctly', (tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      late SizingInformation captured;

      await tester.pumpWidget(
        _buildTestApp(
          child: ResponsiveBuilder(
            builder: (context, sizingInfo) {
              captured = sizingInfo;
              return const SizedBox();
            },
          ),
        ),
      );

      expect(captured.deviceScreenType, DeviceScreenType.desktop);
      expect(captured.isDesktop, isTrue);
      expect(captured.screenSize.width, 1280.0);
    });
  });
}
