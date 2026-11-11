import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_colors/custom_app_colors.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';

/// Minimal branded splash screen for Sustina.
///
/// Displays strictly two visual elements:
/// 1. The official Sustina logo ([AppImages.logo]).
/// 2. The brand name `Sustina`.
///
/// Guided by [CustomAppColors.primary600] and complementary theme shades,
/// with full Light & Dark mode support and zero hardcoded colors.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.96,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );

    _controller.forward();

    // Smooth transition to Landing page after brand display duration
    _navigationTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        context.go(Routes.landing);
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = CustomAppColors.of(context);
    final isDark = context.isDarkMode;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: isDark
              ? RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: [
                    colors.primary100.withValues(alpha: 0.24),
                    colors.background,
                  ],
                  stops: const [0.0, 1.0],
                )
              : RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: [
                    colors.white,
                    colors.primary100.withValues(alpha: 0.38),
                    colors.white,
                  ],
                  stops: const [0.0, 0.65, 1.0],
                ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    isDark ? AppImages.logoSplash : AppImages.logo,
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sustina',
                    style: AppTextStyles.font32Bold.copyWith(
                      color: isDark ? colors.neutral900 : colors.primary600,
                      letterSpacing: 0.8,
                      height: 1.2,
                    ),
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
