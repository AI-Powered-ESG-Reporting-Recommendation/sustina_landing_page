import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/responsive/adaptive_content_container.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/features/landing/presentation/screens/landing_screen.dart';
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
          builder: (context, state) => const _PlaceholderAuthScreen(
            title: 'شاشة تسجيل الدخول',
            subtitle: 'سيتم بناء هذه الشاشة في المرحلة المخصصة لشاشات المصادقة (Auth).',
          ),
        ),
        GoRoute(
          path: Routes.register,
          builder: (context, state) => const _PlaceholderAuthScreen(
            title: 'شاشة تسجيل مؤسسة جديدة',
            subtitle: 'سيتم بناء نموذج تسجيل المؤسسة في مرحلة واجهات المصادقة والتسجيل.',
          ),
        ),
      ],
    );
  }
}

class _PlaceholderAuthScreen extends StatelessWidget {
  const _PlaceholderAuthScreen({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_forward_rounded, color: colors.primary600),
            onPressed: () => context.go(Routes.landing),
            tooltip: 'العودة للصفحة الرئيسية',
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: colors.grey200),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.construction_rounded, size: 48, color: colors.secondary500),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.neutral900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: colors.neutral700,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.go(Routes.landing),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('العودة للصفحة التعريفية'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
