import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

class LandingPillarsSection extends StatelessWidget {
  const LandingPillarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;

    final pillarECard = _PillarCard(
      code: 'E',
      title: l10n.pillarETitle,
      englishTitle: l10n.pillarESubtitle,
      color: colors.primary500,
      lightColor: colors.primary100,
      icon: Icons.forest_rounded,
      summary: l10n.pillarEDesc,
      metricsTitle: l10n.pillarEMetricsTitle,
      metrics: [
        l10n.pillarEMetric1,
        l10n.pillarEMetric2,
        l10n.pillarEMetric3,
        l10n.pillarEMetric4,
        l10n.pillarEMetric5,
      ],
    );

    final pillarSCard = _PillarCard(
      code: 'S',
      title: l10n.pillarSTitle,
      englishTitle: l10n.pillarSSubtitle,
      color: colors.secondary500,
      lightColor: colors.secondary100,
      icon: Icons.groups_rounded,
      summary: l10n.pillarSDesc,
      metricsTitle: l10n.pillarSMetricsTitle,
      metrics: [
        l10n.pillarSMetric1,
        l10n.pillarSMetric2,
        l10n.pillarSMetric3,
        l10n.pillarSMetric4,
        l10n.pillarSMetric5,
      ],
    );

    final pillarGCard = _PillarCard(
      code: 'G',
      title: l10n.pillarGTitle,
      englishTitle: l10n.pillarGSubtitle,
      color: colors.info700,
      lightColor: colors.info300,
      icon: Icons.gavel_rounded,
      summary: l10n.pillarGDesc,
      metricsTitle: l10n.pillarGMetricsTitle,
      metrics: [
        l10n.pillarGMetric1,
        l10n.pillarGMetric2,
        l10n.pillarGMetric3,
        l10n.pillarGMetric4,
        l10n.pillarGMetric5,
      ],
    );

    return Container(
      width: double.infinity,
      color: colors.white,
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
          child: Column(
            children: [
              // Section Header
              AppRevealAnimation(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: colors.secondary100,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colors.secondary300),
                      ),
                      child: Text(
                        l10n.pillarsCategory,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: colors.secondary700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.pillarsTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveValue<double>(
                          mobile: 24,
                          tablet: 30,
                          desktop: 34,
                        ),
                        fontWeight: FontWeight.w800,
                        color: colors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 720),
                      child: Text(
                        l10n.pillarsSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.5,
                          color: colors.neutral700,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              // 3 Pillars Grid
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppRevealAnimation(
                        delay: const Duration(milliseconds: 100),
                        child: pillarECard,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: AppRevealAnimation(
                        delay: const Duration(milliseconds: 200),
                        child: pillarSCard,
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: AppRevealAnimation(
                        delay: const Duration(milliseconds: 300),
                        child: pillarGCard,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    AppRevealAnimation(
                      delay: const Duration(milliseconds: 80),
                      child: pillarECard,
                    ),
                    const SizedBox(height: 20),
                    AppRevealAnimation(
                      delay: const Duration(milliseconds: 140),
                      child: pillarSCard,
                    ),
                    const SizedBox(height: 20),
                    AppRevealAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: pillarGCard,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PillarCard extends StatefulWidget {
  const _PillarCard({
    required this.code,
    required this.title,
    required this.englishTitle,
    required this.color,
    required this.lightColor,
    required this.icon,
    required this.summary,
    required this.metricsTitle,
    required this.metrics,
  });

  final String code;
  final String title;
  final String englishTitle;
  final Color color;
  final Color lightColor;
  final IconData icon;
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? widget.color : colors.grey200,
            width: _isHovered ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? widget.color.withValues(alpha: 0.12)
                  : colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
              blurRadius: _isHovered ? 28 : 14,
              offset: Offset(0, _isHovered ? 10 : 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Badge & Code
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isDark
                        ? widget.color.withValues(alpha: 0.18)
                        : widget.lightColor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(widget.icon, color: widget.color, size: 28),
                ),
                const Spacer(),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                    border: Border.all(color: widget.color.withValues(alpha: 0.3)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    widget.code,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: widget.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Titles
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: colors.neutral900,
              ),
            ),
            Text(
              widget.englishTitle,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: colors.grey600,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 12),

            // Summary
            Text(
              widget.summary,
              style: TextStyle(
                fontSize: 14,
                color: colors.neutral700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: colors.grey200),
            const SizedBox(height: 14),

            // Key Metrics Title
            Text(
              widget.metricsTitle,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
            const SizedBox(height: 10),

            // Metrics bullet list
            ...widget.metrics.map(
              (metric) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        metric,
                        style: TextStyle(
                          fontSize: 13,
                          color: colors.neutral800,
                          height: 1.45,
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
