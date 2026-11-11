import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suatina_web_project/core/helpers/shared_pref_helper.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_data/dark_theme_data.dart';
import 'package:suatina_web_project/core/theme/theme_data/light_theme_data.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/features/landing/presentation/screens/landing_screen.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_cta_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_demo_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_features_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_footer.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_pillars_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_workflow_section.dart';
import 'package:suatina_web_project/features/registration/presentation/screens/company_registration_screen.dart';

const String _scratchDir =
    r'C:\Users\Makaa\.gemini\antigravity\brain\b45dd675-c7b1-4191-877e-fefdbfa38ae9\scratch';

Future<void> _loadCairoFonts() async {
  final loader = FontLoader('Cairo');
  const paths = [
    'assets/fonts/cairo/Cairo-Regular.ttf',
    'assets/fonts/cairo/Cairo-Medium.ttf',
    'assets/fonts/cairo/Cairo-SemiBold.ttf',
    'assets/fonts/cairo/Cairo-Bold.ttf',
    'assets/fonts/cairo/Cairo-ExtraBold.ttf',
    'assets/fonts/cairo/Cairo-Black.ttf',
  ];
  for (final path in paths) {
    final bytes = await File(path).readAsBytes();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

Future<Widget> _buildApp({
  required Widget child,
  required GlobalKey boundaryKey,
  Locale locale = const Locale('en'),
  ThemeMode themeMode = ThemeMode.light,
}) async {
  SharedPreferences.setMockInitialValues({
    'app_locale_code': locale.languageCode,
    'app_theme_mode': themeMode.index,
  });
  await SharedPrefHelper.init();

  final themeCubit = ThemeCubit();
  final localeCubit = LocaleCubit();
  final isRtl = locale.languageCode == 'ar';

  return RepaintBoundary(
    key: boundaryKey,
    child: MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<LocaleCubit>.value(value: localeCubit),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getLightTheme(),
        darkTheme: getDarkTheme(),
        themeMode: themeMode,
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        builder: (context, inner) {
          return Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: inner ?? const SizedBox.shrink(),
          );
        },
        home: child,
      ),
    ),
  );
}

Future<void> _savePng(
  WidgetTester tester,
  GlobalKey boundaryKey,
  String filename,
) async {
  await tester.runAsync(() async {
    final boundary =
        boundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final dir = Directory(_scratchDir);
    if (!dir.existsSync()) dir.createSync(recursive: true);
    await File('${dir.path}/$filename').writeAsBytes(
      byteData!.buffer.asUint8List(),
    );
    image.dispose();
  });
}

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await _loadCairoFonts();
  });

  testWidgets('capture desktop EN light hero & nav + ecosystem', (tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final key = GlobalKey();
    final app = await _buildApp(
      boundaryKey: key,
      child: const LandingScreen(),
      locale: const Locale('en'),
      themeMode: ThemeMode.light,
    );
    await tester.pumpWidget(app);
    await tester.pump(const Duration(milliseconds: 900));
    await _savePng(tester, key, '01_desktop_en_light_hero.png');

    // Click Capabilities in header to scroll to connected ecosystem
    await tester.tap(find.text('Capabilities').first);
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 800));
    await _savePng(tester, key, '02_desktop_en_light_ecosystem.png');

    // Click Workflow
    await tester.tap(find.text('Workflow').first);
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 800));
    await _savePng(tester, key, '03_desktop_en_light_workflow.png');
  });

  testWidgets('capture desktop AR dark ecosystem & footer/CTA', (tester) async {
    tester.view.physicalSize = const Size(1440, 960);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final key = GlobalKey();
    final app = await _buildApp(
      boundaryKey: key,
      child: const LandingScreen(),
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
    );
    await tester.pumpWidget(app);
    await tester.pump(const Duration(milliseconds: 900));
    await _savePng(tester, key, '04_desktop_ar_dark_hero.png');

    await tester.tap(find.text('القدرات الذكية').first);
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump(const Duration(milliseconds: 800));
    await _savePng(tester, key, '05_desktop_ar_dark_ecosystem.png');

    // Scroll to bottom (CTA + Footer)
    await tester.drag(find.byType(SingleChildScrollView).first, const Offset(0, -4500));
    await tester.pump(const Duration(milliseconds: 900));
    await tester.pump(const Duration(milliseconds: 700));
    await _savePng(tester, key, '06_desktop_ar_dark_cta_footer.png');
  });

  testWidgets('capture tablet & mobile connected ecosystem', (tester) async {
    tester.view.physicalSize = const Size(768, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final tabKey = GlobalKey();
    final tabApp = await _buildApp(
      boundaryKey: tabKey,
      child: const Scaffold(
        body: SingleChildScrollView(child: LandingFeaturesSection()),
      ),
      locale: const Locale('en'),
      themeMode: ThemeMode.light,
    );
    await tester.pumpWidget(tabApp);
    await tester.pump(const Duration(milliseconds: 1200));
    await _savePng(tester, tabKey, '07_tablet_en_light_ecosystem.png');

    tester.view.physicalSize = const Size(390, 960);
    final mobKey = GlobalKey();
    final mobApp = await _buildApp(
      boundaryKey: mobKey,
      child: const Scaffold(
        body: SingleChildScrollView(child: LandingFeaturesSection()),
      ),
      locale: const Locale('ar'),
      themeMode: ThemeMode.dark,
    );
    await tester.pumpWidget(mobApp);
    await tester.pump(const Duration(milliseconds: 1200));
    await _savePng(tester, mobKey, '08_mobile_ar_dark_ecosystem.png');
  });

  testWidgets('capture demo & registration screens', (tester) async {
    tester.view.physicalSize = const Size(1440, 1050);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final demoKey = GlobalKey();
    final demoApp = await _buildApp(
      boundaryKey: demoKey,
      child: const Scaffold(
        body: SingleChildScrollView(child: LandingDemoSection()),
      ),
      locale: const Locale('en'),
      themeMode: ThemeMode.dark,
    );
    await tester.pumpWidget(demoApp);
    await tester.pump(const Duration(milliseconds: 900));
    await _savePng(tester, demoKey, '09_desktop_en_dark_demo.png');

    final regKey = GlobalKey();
    final regApp = await _buildApp(
      boundaryKey: regKey,
      child: const CompanyRegistrationScreen(),
      locale: const Locale('ar'),
      themeMode: ThemeMode.light,
    );
    await tester.pumpWidget(regApp);
    await tester.pump(const Duration(milliseconds: 900));
    await _savePng(tester, regKey, '10_desktop_ar_light_register.png');
  });
}
