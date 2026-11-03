import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';

/// Redesigned Minimalist Hero Section:
/// - Completely removes heavy charts and dashboard previews.
/// - Focuses on high-impact typography, dual CTAs (Start Now & Book Demo),
///   and the isolated 3D Earth globe illustration as the majestic visual centerpiece.
/// - Clean eco-themed background with rolling hills and city skyline.
/// - Bottom feature pill bar and smooth scroll-down indicator.
class LandingHeroSection extends StatefulWidget {
  const LandingHeroSection({
    super.key,
    required this.onExplorePressed,
  });

  final VoidCallback onExplorePressed;

  @override
  State<LandingHeroSection> createState() => _LandingHeroSectionState();
}

class _LandingHeroSectionState extends State<LandingHeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isDesktop = context.screenWidth >= 1024;
    final isTablet = context.screenWidth >= 768 && !isDesktop;
    final isMobile = context.screenWidth < 768;

    final horizontalPadding = context.responsiveValue<double>(
      mobile: 16.0,
      tablet: 28.0,
      desktop: 44.0,
      largeDesktop: 64.0,
    );

    return Stack(
      children: [
        // 1. Eco Background Image Layer with Theme-Aware Overlay
        Positioned.fill(
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Eco background image (assets/images/hero_bg_eco.png)
              Image.asset(
                AppImages.heroBgEco,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colors.primary100.withValues(alpha: 0.35),
                          colors.background,
                          colors.secondary100.withValues(alpha: 0.25),
                        ],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                      ),
                    ),
                  );
                },
              ),

              // Theme adaptation overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            colors.background.withValues(alpha: 0.86),
                            colors.background.withValues(alpha: 0.94),
                          ]
                        : [
                            colors.white.withValues(alpha: 0.30),
                            colors.white.withValues(alpha: 0.10),
                            colors.white.withValues(alpha: 0.45),
                          ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ],
          ),
        ),

        // 2. Main Hero Content
        Padding(
          padding: EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: isDesktop ? 36 : 20,
            bottom: isMobile ? 40 : 56,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: AppBreakpoints.maxContentWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Desktop 2-column layout or Mobile/Tablet stacked
                  if (isDesktop)
                    _buildDesktopLayout(context, colors, l10n)
                  else
                    _buildMobileTabletLayout(context, colors, l10n, isTablet),

                  SizedBox(height: isDesktop ? 48 : 32),

                  // Bottom Bar: 3-Feature Pill Bar & Scroll Down Button
                  _buildBottomBar(context, colors, l10n, isMobile),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // DESKTOP LAYOUT (>= 1024px): Spacious Minimalist Split
  // ---------------------------------------------------------------------------
  Widget _buildDesktopLayout(
    BuildContext context,
    dynamic colors,
    AppLocalizations l10n,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text & CTAs Column
        Expanded(
          flex: 12,
          child: AppRevealAnimation(
            delay: const Duration(milliseconds: 100),
            child: _HeroTextAndActions(
              l10n: l10n,
              colors: colors,
              onExplorePressed: widget.onExplorePressed,
            ),
          ),
        ),
        const SizedBox(width: 48),

        // 3D Earth Globe Visual Centerpiece (No clutter, pure beauty)
        Expanded(
          flex: 11,
          child: AppRevealAnimation(
            delay: const Duration(milliseconds: 220),
            child: _EarthVisualCenterpiece(
              floatAnimation: _floatAnimation,
              colors: colors,
              maxHeight: 460,
              maxWidth: 440,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // MOBILE & TABLET LAYOUT (< 1024px): Centered Elegance
  // ---------------------------------------------------------------------------
  Widget _buildMobileTabletLayout(
    BuildContext context,
    dynamic colors,
    AppLocalizations l10n,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text & CTAs (Centered)
        AppRevealAnimation(
          child: _HeroTextAndActions(
            l10n: l10n,
            colors: colors,
            isCentered: true,
            onExplorePressed: widget.onExplorePressed,
          ),
        ),
        const SizedBox(height: 32),

        // 3D Earth Globe Visual Centerpiece
        AppRevealAnimation(
          delay: const Duration(milliseconds: 180),
          child: _EarthVisualCenterpiece(
            floatAnimation: _floatAnimation,
            colors: colors,
            maxHeight: isTablet ? 360 : 280,
            maxWidth: isTablet ? 360 : 280,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // BOTTOM BAR: SCROLL DOWN BUTTON
  // ---------------------------------------------------------------------------
  Widget _buildBottomBar(
    BuildContext context,
    dynamic colors,
    AppLocalizations l10n,
    bool isMobile,
  ) {
    final isDark = context.isDarkMode;
    final isArabic = context.isArabic;

    return Align(
      alignment: isArabic ? Alignment.centerLeft : Alignment.centerRight,
      child: _ScrollDownCircleButton(
        colors: colors,
        isDark: isDark,
        onPressed: widget.onExplorePressed,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HERO TEXT AND DUAL ACTIONS COMPONENT
// -----------------------------------------------------------------------------

class _HeroTextAndActions extends StatelessWidget {
  const _HeroTextAndActions({
    required this.l10n,
    required this.colors,
    required this.onExplorePressed,
    this.isCentered = false,
  });

  final AppLocalizations l10n;
  final dynamic colors;
  final VoidCallback onExplorePressed;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.screenWidth >= 1024;
    final isMobile = context.screenWidth < 768;
    final isArabic = context.isArabic;

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // 1. High-Impact Headline
        Text(
          l10n.refHeroTitle,
          style: TextStyle(
            fontSize: isDesktop ? 50 : (isMobile ? 28 : 38),
            fontWeight: FontWeight.w900,
            color: colors.neutral900,
            fontFamily: 'Cairo',
            height: 1.24,
            letterSpacing: -0.5,
          ),
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 18),

        // 2. Subtitle & Value Proposition
        Text(
          isArabic
              ? 'معاً نحو مستقبل أكثر استدامة — أتمتة حساب البصمة الكربونية (Scope 1, 2, 3)، جمع البيانات بالذكاء الاصطناعي، وإصدار تقارير ESG المعتمدة.'
              : 'Together towards a more sustainable future — Automate greenhouse gas accounting (Scope 1, 2, 3), streamline operational ESG metrics with AI, and generate audit-ready compliance reports.',
          style: TextStyle(
            fontSize: isDesktop ? 17 : (isMobile ? 14 : 15.5),
            fontWeight: FontWeight.w500,
            color: colors.grey700,
            fontFamily: 'Cairo',
            height: 1.6,
          ),
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 36),

        // 3. Dual Calls To Action (Primary: Start Now, Secondary: Book Demo)
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isCentered ? WrapAlignment.center : WrapAlignment.start,
          children: [
            // Primary CTA: "ابدأ الآن" / "Start Now"
            _PrimaryCtaButton(
              label: l10n.refHeroCta,
              colors: colors,
              isArabic: isArabic,
              onPressed: () => context.go(Routes.register),
            ),

            // Secondary CTA: "طلب عرض توضيحي" / "Book a Demo"
            _SecondaryCtaButton(
              label: l10n.heroCtaDemo,
              colors: colors,
              isArabic: isArabic,
              onPressed: onExplorePressed,
            ),
          ],
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// PRIMARY CTA BUTTON
// -----------------------------------------------------------------------------

class _PrimaryCtaButton extends StatefulWidget {
  const _PrimaryCtaButton({
    required this.label,
    required this.colors,
    required this.isArabic,
    required this.onPressed,
  });

  final String label;
  final dynamic colors;
  final bool isArabic;
  final VoidCallback onPressed;

  @override
  State<_PrimaryCtaButton> createState() => _PrimaryCtaButtonState();
}

class _PrimaryCtaButtonState extends State<_PrimaryCtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: widget.colors.primary900,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: (widget.colors.primary900 as Color)
                    .withValues(alpha: _isHovered ? 0.38 : 0.22),
                blurRadius: _isHovered ? 20 : 12,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Directional arrow icon
              Icon(
                widget.isArabic
                    ? Icons.arrow_back_rounded
                    : Icons.arrow_forward_rounded,
                color: widget.colors.white,
                size: 18,
              ),
              const SizedBox(width: 10),

              // Button label
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: widget.colors.white,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SECONDARY CTA BUTTON (BOOK A DEMO)
// -----------------------------------------------------------------------------

class _SecondaryCtaButton extends StatefulWidget {
  const _SecondaryCtaButton({
    required this.label,
    required this.colors,
    required this.isArabic,
    required this.onPressed,
  });

  final String label;
  final dynamic colors;
  final bool isArabic;
  final VoidCallback onPressed;

  @override
  State<_SecondaryCtaButton> createState() => _SecondaryCtaButtonState();
}

class _SecondaryCtaButtonState extends State<_SecondaryCtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.colors.primary500 as Color).withValues(alpha: 0.12)
                : (widget.colors.white as Color)
                    .withValues(alpha: isDark ? 0.08 : 0.85),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: _isHovered
                  ? (widget.colors.primary600 as Color)
                  : (widget.colors.grey300 as Color)
                      .withValues(alpha: isDark ? 0.35 : 0.9),
              width: 1.2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: widget.colors.primary700,
                size: 17,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  color: widget.colors.neutral900,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3D EARTH VISUAL CENTERPIECE
// -----------------------------------------------------------------------------

class _EarthVisualCenterpiece extends StatelessWidget {
  const _EarthVisualCenterpiece({
    required this.floatAnimation,
    required this.colors,
    required this.maxHeight,
    required this.maxWidth,
  });

  final Animation<double> floatAnimation;
  final dynamic colors;
  final double maxHeight;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, floatAnimation.value),
          child: child,
        );
      },
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ambient Radial Green Glow beneath the pedestal
            Container(
              width: maxWidth * 0.85,
              height: maxHeight * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (colors.primary500 as Color).withValues(alpha: 0.22),
                    (colors.primary500 as Color).withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Isolated 3D Earth Globe with Rings & Leaves
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight,
                maxWidth: maxWidth,
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
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SCROLL DOWN CIRCLE BUTTON
// -----------------------------------------------------------------------------

class _ScrollDownCircleButton extends StatefulWidget {
  const _ScrollDownCircleButton({
    required this.colors,
    required this.isDark,
    required this.onPressed,
  });

  final dynamic colors;
  final bool isDark;
  final VoidCallback onPressed;

  @override
  State<_ScrollDownCircleButton> createState() => _ScrollDownCircleButtonState();
}

class _ScrollDownCircleButtonState extends State<_ScrollDownCircleButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
            color: (widget.colors.white as Color)
                .withValues(alpha: widget.isDark ? 0.88 : 0.96),
            shape: BoxShape.circle,
            border: Border.all(
              color: (widget.colors.grey200 as Color)
                  .withValues(alpha: widget.isDark ? 0.35 : 0.8),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: (widget.colors.black as Color)
                    .withValues(alpha: widget.isDark ? 0.3 : 0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.arrow_downward_rounded,
            size: 18,
            color: widget.colors.primary700,
          ),
        ),
      ),
    );
  }
}
