import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingCtaSection extends StatelessWidget {
  const LandingCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isMobile = context.isMobile;
    final isRtl = context.isRtl;
    final isDark = context.isDarkMode;

    // Theme-safe deep emerald gradient & high-contrast light foreground
    final gradientColors = isDark
        ? [colors.primary300, colors.primary200, colors.primary100]
        : [colors.primary600, colors.primary800, colors.primary900];
    final onCtaPrimary = isDark ? colors.neutral900 : colors.grey0;
    final onCtaMuted = onCtaPrimary.withValues(alpha: 0.84);
    final onCtaSubtle = onCtaPrimary.withValues(alpha: 0.72);
    final goldButtonBg = colors.secondary500;
    final goldButtonFg = isDark ? colors.grey0 : colors.primary900;

    return Container(
      width: double.infinity,
      color: colors.grey50,
      child: AdaptiveContentContainer(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveValue<double>(
            mobile: 48,
            tablet: 64,
            desktop: 80,
          ),
          horizontal: ResponsivePadding.pageHorizontal(context),
        ),
        child: AppRevealAnimation(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: AlignmentDirectional.topEnd,
                  end: AlignmentDirectional.bottomStart,
                ),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: isDark
                      ? colors.primary500.withValues(alpha: 0.32)
                      : colors.primary400.withValues(alpha: 0.22),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? colors.black : colors.primary700)
                        .withValues(alpha: isDark ? 0.45 : 0.25),
                    blurRadius: 34,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Subtle decorative ambient circles inside CTA card
                  PositionedDirectional(
                    top: -60,
                    end: -60,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colors.secondary500.withValues(alpha: 0.16),
                            colors.secondary500.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: -70,
                    start: -50,
                    child: Container(
                      width: 240,
                      height: 240,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colors.primary500.withValues(alpha: 0.22),
                            colors.primary500.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Foreground CTA Content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 36 : 56,
                      horizontal: isMobile ? 22 : 48,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: colors.secondary500.withValues(alpha: 0.20),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: colors.secondary400.withValues(alpha: 0.45),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SustinaSvgIcon(
                                assetPath: AppIcons.getStarted,
                                size: 15,
                                color: isDark
                                    ? colors.secondary600
                                    : colors.secondary300,
                                fallbackIcon: Icons.rocket_launch_rounded,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  l10n.ctaBadge,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: isDark
                                        ? colors.secondary700
                                        : colors.secondary200,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        Text(
                          l10n.ctaTitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font32Bold.copyWith(
                            fontSize: context.responsiveValue<double>(
                              mobile: 24,
                              tablet: 31,
                              desktop: 36,
                            ),
                            fontWeight: FontWeight.w900,
                            color: onCtaPrimary,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 14),

                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 640),
                          child: Text(
                            l10n.ctaSubtitle,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.font16Regular.copyWith(
                              fontSize: isMobile ? 14 : 16,
                              color: onCtaMuted,
                              height: 1.6,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        Wrap(
                          spacing: 14,
                          runSpacing: 12,
                          alignment: WrapAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => context.go(Routes.register),
                              icon: Icon(
                                isRtl
                                    ? Icons.arrow_back_rounded
                                    : Icons.arrow_forward_rounded,
                                size: 18,
                              ),
                              label: Text(l10n.ctaRegisterButton),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: goldButtonBg,
                                foregroundColor: goldButtonFg,
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 24 : 30,
                                  vertical: isMobile ? 14 : 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                textStyle: AppTextStyles.font16Bold.copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              onPressed: () => context.go(Routes.login),
                              icon: const Icon(Icons.login_rounded, size: 18),
                              label: Text(l10n.ctaLoginButton),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: onCtaPrimary,
                                side: BorderSide(
                                  color: onCtaPrimary.withValues(alpha: 0.72),
                                  width: 1.4,
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 22 : 28,
                                  vertical: isMobile ? 14 : 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                textStyle: AppTextStyles.font16Bold.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 26),

                        Text(
                          l10n.ctaGuarantees,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: onCtaSubtle,
                          ),
                        ),
                      ],
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
