import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingPillarsSection extends StatelessWidget {
  const LandingPillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;
    final isDark = context.isDarkMode;

    final pillarCards = [
      _PillarCard(
        code: 'E',
        title: l10n.pillarETitle,
        subtitle: l10n.pillarESubtitle,
        accentColor: colors.primary500,
        badgeBg: isDark ? colors.primary100 : colors.primary100,
        svgIconPath: AppIcons.leaf,
        summary: l10n.pillarEDesc,
        metricsTitle: l10n.pillarEMetricsTitle,
        metrics: [
          l10n.pillarEMetric1,
          l10n.pillarEMetric2,
          l10n.pillarEMetric3,
          l10n.pillarEMetric4,
          l10n.pillarEMetric5,
        ],
      ),
      _PillarCard(
        code: 'S',
        title: l10n.pillarSTitle,
        subtitle: l10n.pillarSSubtitle,
        accentColor: colors.secondary500,
        badgeBg: isDark ? colors.secondary100 : colors.secondary100,
        svgIconPath: AppIcons.organization,
        summary: l10n.pillarSDesc,
        metricsTitle: l10n.pillarSMetricsTitle,
        metrics: [
          l10n.pillarSMetric1,
          l10n.pillarSMetric2,
          l10n.pillarSMetric3,
          l10n.pillarSMetric4,
          l10n.pillarSMetric5,
        ],
      ),
      _PillarCard(
        code: 'G',
        title: l10n.pillarGTitle,
        subtitle: l10n.pillarGSubtitle,
        accentColor: colors.info700,
        badgeBg: isDark
            ? colors.info300
            : colors.info300.withValues(alpha: 0.25),
        svgIconPath: AppIcons.carbonPricing,
        summary: l10n.pillarGDesc,
        metricsTitle: l10n.pillarGMetricsTitle,
        metrics: [
          l10n.pillarGMetric1,
          l10n.pillarGMetric2,
          l10n.pillarGMetric3,
          l10n.pillarGMetric4,
          l10n.pillarGMetric5,
        ],
      ),
    ];

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
              category: l10n.pillarsCategory,
              title: l10n.pillarsTitle,
              subtitle: l10n.pillarsSubtitle,
              badgeSvgPath: AppIcons.leaf,
              useSecondaryAccent: true,
            ),
            SizedBox(height: context.responsiveValue(mobile: 32, desktop: 52)),
            if (isDesktop)
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (int i = 0; i < pillarCards.length; i++) ...[
                      Expanded(
                        child: AppRevealAnimation(
                          delay: Duration(milliseconds: 90 * i),
                          child: pillarCards[i],
                        ),
                      ),
                      if (i < pillarCards.length - 1) const SizedBox(width: 24),
                    ],
                  ],
                ),
              )
            else
              Column(
                children: [
                  for (int i = 0; i < pillarCards.length; i++) ...[
                    AppRevealAnimation(
                      delay: Duration(milliseconds: 80 * i),
                      child: pillarCards[i],
                    ),
                    if (i < pillarCards.length - 1) const SizedBox(height: 18),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _PillarCard extends StatefulWidget {
  const _PillarCard({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.badgeBg,
    required this.svgIconPath,
    required this.summary,
    required this.metricsTitle,
    required this.metrics,
  });

  final String code;
  final String title;
  final String subtitle;
  final Color accentColor;
  final Color badgeBg;
  final String svgIconPath;
  final String summary;
  final String metricsTitle;
  final List<String> metrics;

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: _isHovered
                ? widget.accentColor.withValues(alpha: 0.78)
                : colors.grey200,
            width: _isHovered ? 1.6 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.accentColor.withValues(alpha: isDark ? 0.18 : 0.12)
                  : colors.black.withValues(alpha: isDark ? 0.26 : 0.04),
              blurRadius: _isHovered ? 28 : 14,
              offset: Offset(0, _isHovered ? 10 : 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated top accent line
            AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              height: 3.5,
              width: _isHovered ? 72 : 36,
              decoration: BoxDecoration(
                color: widget.accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 18),

            // Top SVG Icon & ESG Code Emblem
            Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: widget.badgeBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: widget.accentColor.withValues(
                        alpha: _isHovered ? 0.45 : 0.15,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SustinaSvgIcon(
                    assetPath: widget.svgIconPath,
                    size: 25,
                    color: widget.accentColor,
                  ),
                ),
                const Spacer(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? widget.accentColor
                        : widget.accentColor.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: widget.accentColor.withValues(alpha: 0.35),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.code,
                    style: AppTextStyles.font18Bold.copyWith(
                      fontWeight: FontWeight.w900,
                      color: _isHovered ? colors.grey0 : widget.accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pillar Titles
            Text(
              widget.title,
              style: AppTextStyles.font20Bold.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: colors.neutral900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              widget.subtitle,
              style: AppTextStyles.font12SemiBold.copyWith(
                color: colors.neutral600,
              ),
            ),
            const SizedBox(height: 12),

            // Summary
            Text(
              widget.summary,
              style: AppTextStyles.font14Regular.copyWith(
                color: colors.neutral700,
                height: 1.55,
              ),
            ),
            const SizedBox(height: 18),
            Divider(color: colors.grey200),
            const SizedBox(height: 14),

            // Key Metrics Title
            Text(
              widget.metricsTitle,
              style: AppTextStyles.font12Bold.copyWith(
                fontSize: 13,
                color: widget.accentColor,
              ),
            ),
            const SizedBox(height: 12),

            // Metrics Checklist
            ...widget.metrics.map(
              (metric) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(
                        Icons.check_circle_rounded,
                        size: 14,
                        color: widget.accentColor,
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        metric,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: colors.neutral800,
                          height: 1.48,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
