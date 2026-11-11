import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingHeroSection extends StatefulWidget {
  const LandingHeroSection({
    super.key,
    required this.onExplorePressed,
    required this.onBookDemoPressed,
  });

  final VoidCallback onExplorePressed;
  final VoidCallback onBookDemoPressed;

  @override
  State<LandingHeroSection> createState() => _LandingHeroSectionState();
}

class _LandingHeroSectionState extends State<LandingHeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ambientController;

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat();
  }

  @override
  void dispose() {
    _ambientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isDesktop = context.isDesktopOrLarger;
    final isTablet = context.isTablet;
    final isMobile = context.isMobile;
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final topPadding = context.responsiveValue<double>(
      mobile: 18,
      tablet: 28,
      desktop: 38,
      largeDesktop: 48,
    );
    final bottomPadding = context.responsiveValue<double>(
      mobile: 36,
      tablet: 48,
      desktop: 56,
    );

    return Stack(
      children: [
        // 1. Eco Horizon Background with Theme-Adaptive Overlay
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppImages.heroBgEco,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colors.primary100.withValues(alpha: 0.4),
                          colors.background,
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            colors.background.withValues(alpha: 0.85),
                            colors.background.withValues(alpha: 0.90),
                            colors.background,
                          ]
                        : [
                            colors.background.withValues(alpha: 0.48),
                            colors.background.withValues(alpha: 0.24),
                            colors.background.withValues(alpha: 0.72),
                          ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Main Hero Content constrained via AdaptiveContentContainer
        AdaptiveContentContainer(
          padding: EdgeInsets.only(
            left: ResponsivePadding.pageHorizontal(context),
            right: ResponsivePadding.pageHorizontal(context),
            top: topPadding,
            bottom: bottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 12,
                      child: AppRevealAnimation(
                        triggerOnVisible: false,
                        delay: const Duration(milliseconds: 60),
                        child: _HeroCopyAndActions(
                          l10n: l10n,
                          ambientController: _ambientController,
                          disableAnimations: disableAnimations,
                          onBookDemoPressed: widget.onBookDemoPressed,
                        ),
                      ),
                    ),
                    const SizedBox(width: 44),
                    Expanded(
                      flex: 11,
                      child: AppRevealAnimation(
                        triggerOnVisible: false,
                        delay: const Duration(milliseconds: 160),
                        child: _HeroEarthCenterpiece(
                          ambientController: _ambientController,
                          disableAnimations: disableAnimations,
                          maxSize: context.isLargeDesktop ? 460 : 410,
                          showFloatingChips: true,
                        ),
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppRevealAnimation(
                      triggerOnVisible: false,
                      child: _HeroCopyAndActions(
                        l10n: l10n,
                        ambientController: _ambientController,
                        disableAnimations: disableAnimations,
                        isCentered: true,
                        onBookDemoPressed: widget.onBookDemoPressed,
                      ),
                    ),
                    const SizedBox(height: 28),
                    AppRevealAnimation(
                      triggerOnVisible: false,
                      delay: const Duration(milliseconds: 140),
                      child: _HeroEarthCenterpiece(
                        ambientController: _ambientController,
                        disableAnimations: disableAnimations,
                        maxSize: isTablet ? 350 : 255,
                        showFloatingChips: isTablet,
                      ),
                    ),
                  ],
                ),

              SizedBox(height: isDesktop ? 44 : 28),

              // 3. Trust Capabilities Strip & Scroll Down Action
              AppRevealAnimation(
                triggerOnVisible: false,
                delay: const Duration(milliseconds: 240),
                child: _HeroTrustStrip(
                  isMobile: isMobile,
                  onScrollExplore: widget.onExplorePressed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroCopyAndActions extends StatelessWidget {
  const _HeroCopyAndActions({
    required this.l10n,
    required this.ambientController,
    required this.disableAnimations,
    required this.onBookDemoPressed,
    this.isCentered = false,
  });

  final AppLocalizations l10n;
  final AnimationController ambientController;
  final bool disableAnimations;
  final VoidCallback onBookDemoPressed;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    final titleFontSize = context.responsiveValue<double>(
      mobile: 28,
      tablet: 37,
      desktop: 44,
      largeDesktop: 50,
    );
    final subtitleFontSize = context.responsiveValue<double>(
      mobile: 14,
      tablet: 15.5,
      desktop: 16.5,
      largeDesktop: 17.5,
    );

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Live ESG Badge with Pulsing Dot
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: colors.white.withValues(alpha: isDark ? 0.85 : 0.90),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: colors.primary500.withValues(alpha: isDark ? 0.42 : 0.28),
            ),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: isDark ? 0.22 : 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RepaintBoundary(
                child: AnimatedBuilder(
                  animation: ambientController,
                  builder: (context, _) {
                    final pulse = disableAnimations
                        ? 0.6
                        : 0.45 +
                            0.55 *
                                (0.5 +
                                    0.5 *
                                        math.sin(
                                          ambientController.value * 2 * math.pi,
                                        ));
                    return Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.primary500,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: colors.primary500.withValues(
                              alpha: 0.55 * pulse,
                            ),
                            blurRadius: 8 * pulse,
                            spreadRadius: 2 * pulse,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 9),
              Flexible(
                child: Text(
                  l10n.heroTrustLiveBadge,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: isDark ? colors.primary700 : colors.primary600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Headline
        Text(
          l10n.refHeroTitle,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: AppTextStyles.font48Bold.copyWith(
            fontSize: titleFontSize,
            fontWeight: FontWeight.w900,
            color: colors.neutral900,
            height: 1.24,
          ),
        ),
        const SizedBox(height: 16),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            l10n.heroSubtitle,
            textAlign: isCentered ? TextAlign.center : TextAlign.start,
            style: AppTextStyles.font16Medium.copyWith(
              fontSize: subtitleFontSize,
              color: colors.neutral700,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 30),

        // Dual CTAs
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            SustinaPrimaryButton(
              label: l10n.heroCtaStart,
              onPressed: () => context.go(Routes.register),
            ),
            SustinaSecondaryButton(
              label: l10n.heroCtaDemo,
              icon: Icons.calendar_month_rounded,
              onPressed: onBookDemoPressed,
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroEarthCenterpiece extends StatelessWidget {
  const _HeroEarthCenterpiece({
    required this.ambientController,
    required this.disableAnimations,
    required this.maxSize,
    required this.showFloatingChips,
  });

  final AnimationController ambientController;
  final bool disableAnimations;
  final double maxSize;
  final bool showFloatingChips;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;

    return RepaintBoundary(
      child: SizedBox(
        height: maxSize + 24,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Breathing radial aura behind globe
            AnimatedBuilder(
              animation: ambientController,
              builder: (context, _) {
                final t = disableAnimations
                    ? 0.5
                    : 0.5 +
                        0.5 * math.sin(ambientController.value * 2 * math.pi);
                return Container(
                  width: maxSize * (0.82 + 0.06 * t),
                  height: maxSize * (0.82 + 0.06 * t),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        colors.primary500.withValues(
                          alpha: isDark ? 0.24 : 0.20,
                        ),
                        colors.secondary500.withValues(
                          alpha: isDark ? 0.09 : 0.07,
                        ),
                        colors.background.withValues(alpha: 0),
                      ],
                      stops: const [0.0, 0.55, 1.0],
                    ),
                  ),
                );
              },
            ),

            // Levitating 3D Earth Globe
            AnimatedBuilder(
              animation: ambientController,
              builder: (context, child) {
                final dy = disableAnimations
                    ? 0.0
                    : 6.0 * math.sin(ambientController.value * 2 * math.pi);
                return Transform.translate(
                  offset: Offset(0, dy),
                  child: child,
                );
              },
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: maxSize,
                  maxWidth: maxSize,
                ),
                child: Image.asset(
                  AppImages.heroEarth,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.heroGlobe,
                      fit: BoxFit.contain,
                    );
                  },
                ),
              ),
            ),

            // Floating Micro-KPI Chips (Desktop & Tablet)
            if (showFloatingChips) ...[
              PositionedDirectional(
                top: maxSize * 0.08,
                start: 6,
                child: _FloatingHeroBadge(
                  ambientController: ambientController,
                  phase: 0.4,
                  disableAnimations: disableAnimations,
                  svgIconPath: AppIcons.emissions,
                  label: l10n.heroChipScope,
                  accentColor: colors.primary500,
                ),
              ),
              PositionedDirectional(
                top: maxSize * 0.26,
                end: 2,
                child: _FloatingHeroBadge(
                  ambientController: ambientController,
                  phase: 2.1,
                  disableAnimations: disableAnimations,
                  svgIconPath: AppIcons.documentUploadIcon,
                  label: l10n.heroChipOcr,
                  accentColor: colors.secondary500,
                ),
              ),
              PositionedDirectional(
                bottom: maxSize * 0.14,
                start: 16,
                child: _FloatingHeroBadge(
                  ambientController: ambientController,
                  phase: 3.9,
                  disableAnimations: disableAnimations,
                  svgIconPath: AppIcons.leaf,
                  label: l10n.heroChipEsg,
                  accentColor: colors.info700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FloatingHeroBadge extends StatelessWidget {
  const _FloatingHeroBadge({
    required this.ambientController,
    required this.phase,
    required this.disableAnimations,
    required this.svgIconPath,
    required this.label,
    required this.accentColor,
  });

  final AnimationController ambientController;
  final double phase;
  final bool disableAnimations;
  final String svgIconPath;
  final String label;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return AnimatedBuilder(
      animation: ambientController,
      builder: (context, child) {
        final dy = disableAnimations
            ? 0.0
            : 5.0 * math.sin(ambientController.value * 2 * math.pi + phase);
        return Transform.translate(offset: Offset(0, dy), child: child);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colors.white.withValues(alpha: isDark ? 0.92 : 0.95),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: accentColor.withValues(alpha: isDark ? 0.45 : 0.28),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: isDark ? 0.34 : 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: SustinaSvgIcon(
                assetPath: svgIconPath,
                size: 14,
                color: accentColor,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.font12Bold.copyWith(
                color: colors.neutral900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroTrustStrip extends StatelessWidget {
  const _HeroTrustStrip({
    required this.isMobile,
    required this.onScrollExplore,
  });

  final bool isMobile;
  final VoidCallback onScrollExplore;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;

    final trustItems = [
      (AppIcons.emissions, l10n.heroTrustPill1),
      (AppIcons.documentUploadIcon, l10n.heroTrustPill2),
      (AppIcons.chat, l10n.heroTrustPill3),
      (AppIcons.report, l10n.heroTrustPill4),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 20,
        vertical: isMobile ? 14 : 16,
      ),
      decoration: BoxDecoration(
        color: colors.white.withValues(alpha: isDark ? 0.80 : 0.90),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colors.grey200.withValues(alpha: isDark ? 0.75 : 0.95),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: isMobile ? 12 : 24,
              runSpacing: 10,
              alignment:
                  isMobile ? WrapAlignment.center : WrapAlignment.spaceBetween,
              children: [
                for (final item in trustItems)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: isDark
                              ? colors.primary100
                              : colors.primary100.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: SustinaSvgIcon(
                          assetPath: item.$1,
                          size: 15,
                          color: isDark ? colors.primary700 : colors.primary600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.$2,
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: colors.neutral800,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (!isMobile) ...[
            const SizedBox(width: 16),
            _ScrollDownCircleButton(
              tooltip: l10n.heroScrollTooltip,
              onPressed: onScrollExplore,
            ),
          ],
        ],
      ),
    );
  }
}

class _ScrollDownCircleButton extends StatefulWidget {
  const _ScrollDownCircleButton({
    required this.tooltip,
    required this.onPressed,
  });

  final String tooltip;
  final VoidCallback onPressed;

  @override
  State<_ScrollDownCircleButton> createState() =>
      _ScrollDownCircleButtonState();
}

class _ScrollDownCircleButtonState extends State<_ScrollDownCircleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 38,
            height: 38,
            transform: _isHovered
                ? Matrix4.translationValues(0, 3, 0)
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: _isHovered ? colors.primary500 : colors.grey100,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isHovered ? colors.primary500 : colors.grey200,
              ),
            ),
            child: Icon(
              Icons.arrow_downward_rounded,
              size: 18,
              color: _isHovered
                  ? colors.grey0
                  : (isDark ? colors.primary700 : colors.primary600),
            ),
          ),
        ),
      ),
    );
  }
}
