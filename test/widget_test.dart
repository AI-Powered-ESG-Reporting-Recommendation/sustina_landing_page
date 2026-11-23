import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suatina_web_project/core/constants/social_links.dart';
import 'package:suatina_web_project/core/helpers/app_validators.dart';
import 'package:suatina_web_project/core/helpers/shared_pref_helper.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_data/dark_theme_data.dart';
import 'package:suatina_web_project/core/theme/theme_data/light_theme_data.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/core/widgets/sustina_social_links.dart';
import 'package:suatina_web_project/features/landing/presentation/screens/landing_screen.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_demo_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_footer.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_header.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_nav_drawer.dart';
import 'package:suatina_web_project/features/registration/presentation/screens/company_registration_screen.dart';

Future<Widget> _buildTestHarness({
  required Widget child,
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

  return MultiBlocProvider(
    providers: [
      BlocProvider<ThemeCubit>.value(value: themeCubit),
      BlocProvider<LocaleCubit>.value(value: localeCubit),
    ],
    child: MaterialApp(
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
  );
}

void main() {
  group('AppValidators', () {
    test('validates international and regional phone numbers', () {
      expect(AppValidators.validatePhone(''), isNotNull);
      expect(AppValidators.validatePhone('1234'), isNotNull);
      expect(AppValidators.validatePhone('+966 50 123 4567'), isNull);
      expect(AppValidators.validatePhone('0501234567'), isNull);
      expect(AppValidators.validatePhone('01012345678'), isNull);
      expect(AppValidators.validatePhone('+201012345678'), isNull);
    });

    test('validates business email addresses', () {
      expect(AppValidators.validateEmail(''), isNotNull);
      expect(AppValidators.validateEmail('invalid-email'), isNotNull);
      expect(AppValidators.validateEmail('sara@sustina.io'), isNull);
    });
  });

  group('SustinaSocialCatalog', () {
    test('exposes exact official social URLs without Linktree replacement', () {
      expect(
        SustinaSocialCatalog.facebookUrl,
        'https://www.facebook.com/sustiina',
      );
      expect(
        SustinaSocialCatalog.instagramUrl,
        'https://www.instagram.com/__sustina__',
      );
      expect(
        SustinaSocialCatalog.linkedinUrl,
        'https://www.linkedin.com/company/sustiina/',
      );
      expect(
        SustinaSocialCatalog.xUrl,
        'https://x.com/__sustina__',
      );
    });
  });

  group('LandingScreen responsive, social & no-login verification', () {
    testWidgets(
      'Desktop English Light Mode has social icons, zero Login buttons, and zero overflow',
      (tester) async {
        tester.view.physicalSize = const Size(1440, 900);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final app = await _buildTestHarness(
          child: const LandingScreen(),
          locale: const Locale('en'),
          themeMode: ThemeMode.light,
        );
        await tester.pumpWidget(app);
        await tester.pump(const Duration(milliseconds: 200));

        // Login button completely removed from Landing Page
        expect(find.text('Sign In'), findsNothing);
        expect(find.text('تسجيل الدخول'), findsNothing);

        // Navbar matches actual landing sections & embeds social links
        expect(
          find.descendant(
            of: find.byType(LandingHeader),
            matching: find.byType(SustinaSocialLinksRow),
          ),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: find.byType(LandingFooter),
            matching: find.byType(SustinaSocialLinksRow),
          ),
          findsOneWidget,
        );
        expect(find.text('Home'), findsWidgets);
        expect(find.text('ESG Pillars'), findsWidgets);
        expect(find.text('Capabilities'), findsWidgets);
        expect(find.text('Workflow'), findsWidgets);
        expect(find.text('Book a Demo'), findsWidgets);
        expect(find.text('Onboarding'), findsWidgets);
      },
    );

    testWidgets(
      'Standard Desktop 1024px fits navbar + social icons without overflow',
      (tester) async {
        tester.view.physicalSize = const Size(1024, 800);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final app = await _buildTestHarness(
          child: const LandingScreen(),
          locale: const Locale('ar'),
          themeMode: ThemeMode.dark,
        );
        await tester.pumpWidget(app);
        await tester.pump(const Duration(milliseconds: 200));

        expect(find.text('تسجيل الدخول'), findsNothing);
        expect(
          find.descendant(
            of: find.byType(LandingHeader),
            matching: find.byType(SustinaSocialLinksRow),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Tablet Arabic Dark Mode (RTL) renders header social icons cleanly',
      (tester) async {
        tester.view.physicalSize = const Size(768, 1024);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final app = await _buildTestHarness(
          child: const LandingScreen(),
          locale: const Locale('ar'),
          themeMode: ThemeMode.dark,
        );
        await tester.pumpWidget(app);
        await tester.pump(const Duration(milliseconds: 200));

        expect(find.byIcon(Icons.menu_rounded), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(LandingHeader),
            matching: find.byType(SustinaSocialLinksRow),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'Mobile English Light Mode opens drawer with social links and no Login button',
      (tester) async {
        tester.view.physicalSize = const Size(390, 844);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final app = await _buildTestHarness(
          child: const LandingScreen(),
          locale: const Locale('en'),
          themeMode: ThemeMode.light,
        );
        await tester.pumpWidget(app);
        await tester.pump(const Duration(milliseconds: 200));

        await tester.tap(find.byIcon(Icons.menu_rounded));
        await tester.pump(const Duration(milliseconds: 400));

        expect(find.byType(LandingNavDrawer), findsOneWidget);
        expect(
          find.descendant(
            of: find.byType(LandingNavDrawer),
            matching: find.byType(SustinaSocialLinksRow),
          ),
          findsOneWidget,
        );
        expect(find.text('Sign In'), findsNothing);
      },
    );
  });

  group('LandingDemoSection flow', () {
    testWidgets('validates required inputs and transitions to confirmed state', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1280, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final app = await _buildTestHarness(
        child: const Scaffold(
          body: SingleChildScrollView(child: LandingDemoSection()),
        ),
      );
      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Request Live Demo'));
      await tester.tap(find.text('Request Live Demo'));
      await tester.pumpAndSettle();
      expect(find.text('This field is required'), findsWidgets);

      final textFields = find.byType(TextFormField);
      await tester.enterText(textFields.at(0), 'Sarah Al-Qahtani');
      await tester.enterText(textFields.at(1), 'Horizon Industrial Group');
      await tester.enterText(textFields.at(2), 'sarah@horizon.com');
      await tester.enterText(textFields.at(3), '+966501234567');
      await tester.enterText(textFields.at(4), 'ESG Director');

      await tester.tap(find.byType(DropdownButtonFormField<String>).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Industrial & Manufacturing').last);
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('Request Live Demo'));
      await tester.tap(find.text('Request Live Demo'));
      await tester.pump(const Duration(milliseconds: 800));
      await tester.pumpAndSettle();

      expect(
        find.text('Thank You! Your Demo Request Is Confirmed'),
        findsOneWidget,
      );
    });
  });

  group('CompanyRegistrationScreen 6-stage flow', () {
    testWidgets(
      'submits basic company info without package/payment and transitions to Stage 2 confirmation',
      (tester) async {
        tester.view.physicalSize = const Size(1400, 1100);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        final app = await _buildTestHarness(
          child: const CompanyRegistrationScreen(),
        );
        await tester.pumpWidget(app);
        await tester.pumpAndSettle();

        expect(
          find.textContaining('No package selection or payment'),
          findsOneWidget,
        );

        final textFields = find.byType(TextFormField);
        await tester.enterText(textFields.at(0), 'Arabia Green Co.');
        await tester.enterText(textFields.at(1), 'contact@arabiagreen.com');
        await tester.enterText(textFields.at(2), 'Khalid Al-Harbi');
        await tester.enterText(textFields.at(3), '+966551234567');

        final dropdowns = find.byType(DropdownButtonFormField<String>);
        await tester.tap(dropdowns.at(0));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Energy, Oil & Petrochemicals').last);
        await tester.pumpAndSettle();

        await tester.tap(dropdowns.at(1));
        await tester.pumpAndSettle();
        await tester.tap(find.text('51 – 250 Employees').last);
        await tester.pumpAndSettle();

        await tester.tap(dropdowns.at(2));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Saudi Arabia').last);
        await tester.pumpAndSettle();

        await tester.ensureVisible(find.text('Submit Company Registration'));
        await tester.tap(find.text('Submit Company Registration'));
        await tester.pump(const Duration(milliseconds: 900));
        await tester.pumpAndSettle();

        expect(
          find.text('Registration Request Received Successfully!'),
          findsOneWidget,
        );
        expect(find.text('Arabia Green Co.'), findsOneWidget);
        expect(find.text('Completed'), findsNWidgets(2));
        expect(find.text('Up Next'), findsOneWidget);
      },
    );
  });
}
