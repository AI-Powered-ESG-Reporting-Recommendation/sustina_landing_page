import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/adaptive_content_container.dart';
import 'package:suatina_web_project/core/responsive/responsive_extensions.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/landing/presentation/screens/landing_screen.dart';
import 'package:suatina_web_project/features/registration/presentation/screens/company_registration_screen.dart';
import 'package:suatina_web_project/features/splash/presentation/screens/splash_screen.dart';

abstract class AppRouter {
  static late final GoRouter router;

  static void initRouter() {
    router = GoRouter(
      initialLocation: Routes.splash,
      routes: [
        GoRoute(
          path: Routes.splash,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: Routes.landing,
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: Routes.onboarding,
          builder: (context, state) => const LandingScreen(),
        ),
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const _PlaceholderAuthScreen(),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => const CompanyRegistrationScreen(),
        ),
      ],
    );
  }
}

class _PlaceholderAuthScreen extends StatelessWidget {
  const _PlaceholderAuthScreen();

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isRtl = context.isRtl;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.white,
        surfaceTintColor: colors.white.withValues(alpha: 0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            isRtl ? Icons.arrow_forward_rounded : Icons.arrow_back_rounded,
            color: isDark ? colors.primary700 : colors.primary600,
          ),
          onPressed: () => context.go(Routes.landing),
          tooltip: l10n.backToLanding,
        ),
        title: Text(
          l10n.loginPlaceholderTitle,
          style: AppTextStyles.font16Bold.copyWith(
            color: colors.neutral900,
          ),
        ),
      ),
      body: Center(
        child: AdaptiveFormContainer(
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: colors.grey200),
              boxShadow: [
                BoxShadow(
                  color: colors.black.withValues(alpha: isDark ? 0.28 : 0.05),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: isDark
                        ? colors.secondary100
                        : colors.secondary100.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SustinaSvgIcon(
                    assetPath: AppIcons.organization,
                    size: 30,
                    color: colors.secondary500,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  l10n.loginPlaceholderTitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font20Bold.copyWith(
                    color: colors.neutral900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.loginPlaceholderSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font14Regular.copyWith(
                    color: colors.neutral700,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 26),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    SustinaPrimaryButton(
                      label: l10n.navRegister,
                      onPressed: () => context.go(Routes.register),
                    ),
                    SustinaSecondaryButton(
                      label: l10n.backToLanding,
                      onPressed: () => context.go(Routes.landing),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
