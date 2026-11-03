import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

class LandingCtaSection extends StatelessWidget {
  const LandingCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isMobile = context.isMobile;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      color: isDark ? colors.background : colors.white,
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveValue<double>(
          mobile: 48,
          tablet: 64,
          desktop: 80,
        ),
        horizontal: context.responsiveValue<double>(
          mobile: 16,
          tablet: 24,
          desktop: 40,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth),
          child: AppRevealAnimation(
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 36 : 56,
                horizontal: isMobile ? 24 : 48,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    colors.primary600,
                    colors.primary800,
                    colors.primary900,
                  ],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: colors.primary600.withValues(alpha: isDark ? 0.35 : 0.28),
                    blurRadius: 36,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: colors.secondary500.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: colors.secondary400.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.rocket_launch_rounded, size: 16, color: colors.secondary300),
                        const SizedBox(width: 8),
                        Text(
                          l10n.ctaBadge,
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: colors.secondary200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Headline
                  Text(
                    l10n.ctaTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: context.responsiveValue<double>(
                        mobile: 24,
                        tablet: 32,
                        desktop: 36,
                      ),
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Subtitle
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Text(
                      l10n.ctaSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16.5,
                        color: Colors.white.withValues(alpha: 0.88),
                        height: 1.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Buttons
                  Wrap(
                    spacing: 14,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => context.push(Routes.register),
                        icon: Icon(
                          isRtl ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
                          size: 18,
                        ),
                        label: Text(l10n.ctaRegisterButton),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colors.secondary500,
                          foregroundColor: colors.primary900,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 32,
                            vertical: isMobile ? 14 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      OutlinedButton.icon(
                        onPressed: () => context.push(Routes.login),
                        icon: const Icon(Icons.login_rounded, size: 18),
                        label: Text(l10n.ctaLoginButton),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white, width: 1.4),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 22 : 28,
                            vertical: isMobile ? 14 : 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Guarantees Note
                  Text(
                    l10n.ctaGuarantees,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.72),
                      fontWeight: FontWeight.w500,
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
