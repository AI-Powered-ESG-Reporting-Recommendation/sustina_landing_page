import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';

class LandingRegistrationOverviewSection extends StatefulWidget {
  const LandingRegistrationOverviewSection({
    super.key,
    required this.onBookDemoPressed,
  });

  final VoidCallback onBookDemoPressed;

  @override
  State<LandingRegistrationOverviewSection> createState() =>
      _LandingRegistrationOverviewSectionState();
}

class _LandingRegistrationOverviewSectionState
    extends State<LandingRegistrationOverviewSection> {
  int _selectedStageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    final stages = [
      (
        '01',
        AppIcons.organization,
        l10n.regStage1Title,
        l10n.regStage1Desc,
      ),
      (
        '02',
        AppIcons.done,
        l10n.regStage2Title,
        l10n.regStage2Desc,
      ),
      (
        '03',
        AppIcons.chat,
        l10n.regStage3Title,
        l10n.regStage3Desc,
      ),
      (
        '04',
        AppIcons.task,
        l10n.regStage4Title,
        l10n.regStage4Desc,
      ),
      (
        '05',
        AppIcons.carbonPricing,
        l10n.regStage5Title,
        l10n.regStage5Desc,
      ),
      (
        '06',
        AppIcons.leaf,
        l10n.regStage6Title,
        l10n.regStage6Desc,
      ),
    ];

    final columns = context.responsiveValue<int>(
      mobile: 1,
      tablet: 2,
      desktop: 3,
      largeDesktop: 3,
    );

    return Container(
      width: double.infinity,
      color: colors.background,
      child: AdaptiveContentContainer(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveValue<double>(
            mobile: 52,
            tablet: 68,
            desktop: 88,
          ),
          horizontal: ResponsivePadding.pageHorizontal(context),
        ),
        child: Column(
          children: [
            SustinaSectionHeader(
              category: l10n.regOverviewCategory,
              title: l10n.regOverviewTitle,
              subtitle: l10n.regOverviewSubtitle,
              badgeSvgPath: AppIcons.organization,
              useSecondaryAccent: true,
            ),
            const SizedBox(height: 18),

            // Zero-Upfront-Payment Guarantee Pill
            AppRevealAnimation(
              delay: const Duration(milliseconds: 80),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? colors.secondary100
                      : colors.secondary100.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: colors.secondary500.withValues(alpha: 0.45),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 17,
                      color: isDark
                          ? colors.secondary600
                          : colors.secondary700,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        l10n.regOverviewNoPaymentPill,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font12Bold.copyWith(
                          color: isDark
                              ? colors.secondary700
                              : colors.secondary800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.responsiveValue(mobile: 28, desktop: 44)),

            // 6-Stage Journey Interactive Cards
            LayoutBuilder(
              builder: (context, constraints) {
                final spacing = ResponsiveGap.gutter(context);
                final itemWidth = ResponsiveGridHelper.itemWidthForColumns(
                  totalWidth: constraints.maxWidth,
                  columns: columns,
                  spacing: spacing,
                );

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    for (int i = 0; i < stages.length; i++)
                      SizedBox(
                        width: itemWidth,
                        child: AppRevealAnimation(
                          delay: Duration(milliseconds: 60 * i),
                          child: _OverviewStageCard(
                            number: stages[i].$1,
                            svgPath: stages[i].$2,
                            title: stages[i].$3,
                            description: stages[i].$4,
                            isSelected: _selectedStageIndex == i,
                            isFirstStep: i == 0,
                            onTap: () => setState(() => _selectedStageIndex = i),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),

            SizedBox(height: context.responsiveValue(mobile: 28, desktop: 40)),

            // Clear Primary CTA -> /register
            AppRevealAnimation(
              delay: const Duration(milliseconds: 180),
              child: Wrap(
                spacing: 14,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  SustinaPrimaryButton(
                    label: l10n.regOverviewCta,
                    icon: Icons.apartment_rounded,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 32,
                      vertical: 15,
                    ),
                    onPressed: () => context.go(Routes.register),
                  ),
                  SustinaSecondaryButton(
                    label: l10n.regOverviewSecondaryCta,
                    icon: Icons.calendar_month_rounded,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 22 : 26,
                      vertical: 15,
                    ),
                    onPressed: widget.onBookDemoPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewStageCard extends StatefulWidget {
  const _OverviewStageCard({
    required this.number,
    required this.svgPath,
    required this.title,
    required this.description,
    required this.isSelected,
    required this.isFirstStep,
    required this.onTap,
  });

  final String number;
  final String svgPath;
  final String title;
  final String description;
  final bool isSelected;
  final bool isFirstStep;
  final VoidCallback onTap;

  @override
  State<_OverviewStageCard> createState() => _OverviewStageCardState();
}

class _OverviewStageCardState extends State<_OverviewStageCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final highlighted = widget.isSelected || _hovered;
    final accent =
        widget.isFirstStep ? colors.primary500 : colors.secondary500;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, highlighted ? -4 : 0, 0),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: highlighted
                  ? accent.withValues(alpha: 0.78)
                  : colors.grey200,
              width: highlighted ? 1.6 : 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: highlighted
                    ? accent.withValues(alpha: isDark ? 0.20 : 0.12)
                    : colors.black.withValues(alpha: isDark ? 0.22 : 0.03),
                blurRadius: highlighted ? 22 : 12,
                offset: Offset(0, highlighted ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: isDark ? 0.16 : 0.11),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    alignment: Alignment.center,
                    child: widget.svgPath == AppIcons.done
                        ? Icon(
                            Icons.mark_email_read_outlined,
                            size: 21,
                            color: accent,
                          )
                        : SustinaSvgIcon(
                            assetPath: widget.svgPath,
                            size: 20,
                            color: accent,
                          ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: highlighted
                          ? accent
                          : accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      widget.number,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: highlighted ? colors.grey0 : accent,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: AppTextStyles.font16Bold.copyWith(
                  color: colors.neutral900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.description,
                style: AppTextStyles.font13Regular.copyWith(
                  color: colors.neutral700,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

