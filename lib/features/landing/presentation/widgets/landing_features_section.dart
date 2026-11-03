import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

class LandingFeaturesSection extends StatelessWidget {
  const LandingFeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final columns = context.responsiveValue<int>(
      mobile: 1,
      tablet: 2,
      desktop: 3,
      largeDesktop: 3,
    );

    return Container(
      width: double.infinity,
      color: colors.grey50,
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
              // Header
              AppRevealAnimation(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: colors.primary100,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: colors.primary300),
                      ),
                      child: Text(
                        l10n.featuresCategory,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: colors.primary600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.featuresTitle,
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
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Text(
                        l10n.featuresSubtitle,
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

              // Features Grid
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
                      _FeatureItem(
                        width: itemWidth,
                        delay: const Duration(milliseconds: 60),
                        icon: Icons.auto_awesome_rounded,
                        tag: l10n.feature1Badge,
                        tagColor: colors.primary500,
                        title: l10n.feature1Title,
                        description: l10n.feature1Desc,
                      ),
                      _FeatureItem(
                        width: itemWidth,
                        delay: const Duration(milliseconds: 120),
                        icon: Icons.document_scanner_rounded,
                        tag: l10n.feature2Badge,
                        tagColor: colors.primary600,
                        title: l10n.feature2Title,
                        description: l10n.feature2Desc,
                      ),
                      _FeatureItem(
                        width: itemWidth,
                        delay: const Duration(milliseconds: 180),
                        icon: Icons.speed_rounded,
                        tag: l10n.feature3Badge,
                        tagColor: colors.secondary500,
                        title: l10n.feature3Title,
                        description: l10n.feature3Desc,
                      ),
                      _FeatureItem(
                        width: itemWidth,
                        delay: const Duration(milliseconds: 240),
                        icon: Icons.schema_rounded,
                        tag: l10n.feature4Badge,
                        tagColor: colors.info700,
                        title: l10n.feature4Title,
                        description: l10n.feature4Desc,
                      ),
                      _FeatureItem(
                        width: itemWidth,
                        delay: const Duration(milliseconds: 300),
                        icon: Icons.local_shipping_rounded,
                        tag: l10n.feature5Badge,
                        tagColor: colors.secondary700,
                        title: l10n.feature5Title,
                        description: l10n.feature5Desc,
                      ),
                      _FeatureItem(
                        width: itemWidth,
                        delay: const Duration(milliseconds: 360),
                        icon: Icons.picture_as_pdf_rounded,
                        tag: l10n.feature6Badge,
                        tagColor: colors.primary600,
                        title: l10n.feature6Title,
                        description: l10n.feature6Desc,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatefulWidget {
  const _FeatureItem({
    required this.width,
    required this.delay,
    required this.icon,
    required this.tag,
    required this.tagColor,
    required this.title,
    required this.description,
  });

  final double width;
  final Duration delay;
  final IconData icon;
  final String tag;
  final Color tagColor;
  final String title;
  final String description;

  @override
  State<_FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<_FeatureItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return SizedBox(
      width: widget.width,
      child: AppRevealAnimation(
        delay: widget.delay,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
            padding: const EdgeInsets.all(26),
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: _isHovered
                    ? widget.tagColor.withValues(alpha: 0.7)
                    : colors.grey200,
                width: _isHovered ? 1.6 : 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.tagColor.withValues(alpha: 0.1)
                      : colors.black.withValues(alpha: isDark ? 0.2 : 0.03),
                  blurRadius: _isHovered ? 24 : 12,
                  offset: Offset(0, _isHovered ? 8 : 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Icon & Tag
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: widget.tagColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(widget.icon, color: widget.tagColor, size: 26),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: widget.tagColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.tag,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: widget.tagColor,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: colors.neutral900,
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 13.8,
                    color: colors.neutral700,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
