import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/landing/presentation/models/landing_nav_item.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({
    super.key,
    required this.activeSectionId,
    required this.isScrolled,
    required this.onNavigateToSection,
    required this.onOpenDrawer,
  });

  final String activeSectionId;
  final bool isScrolled;
  final void Function(String sectionKey) onNavigateToSection;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isArabic = context.isArabic;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;
    final isDesktop = context.isDesktopOrLarger;
    final isLargeDesktop = context.isLargeDesktop;
    final navItems = LandingNavCatalog.items(l10n);

    final horizontalMargin = context.responsiveValue<double>(
      mobile: 10.0,
      tablet: 20.0,
      desktop: 24.0,
      largeDesktop: 40.0,
    );

    final navGap = context.responsiveValue<double>(
      mobile: 4.0,
      tablet: 4.0,
      desktop: 4.0,
      largeDesktop: 10.0,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: isScrolled ? 10 : 14,
        bottom: 8,
        left: horizontalMargin,
        right: horizontalMargin,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.maxContentWidth,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: 64,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 16 : (isMobile ? 10 : 14),
                ),
                decoration: BoxDecoration(
                  color: colors.white.withValues(
                    alpha: isDark
                        ? (isScrolled ? 0.92 : 0.84)
                        : (isScrolled ? 0.96 : 0.90),
                  ),
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(
                    color: isScrolled
                        ? colors.primary500.withValues(
                            alpha: isDark ? 0.34 : 0.24,
                          )
                        : colors.grey200.withValues(
                            alpha: isDark ? 0.65 : 0.85,
                          ),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.black.withValues(
                        alpha: isDark
                            ? (isScrolled ? 0.42 : 0.28)
                            : (isScrolled ? 0.08 : 0.04),
                      ),
                      blurRadius: isScrolled ? 24 : 16,
                      offset: Offset(0, isScrolled ? 8 : 4),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // 1. Brand Logo + Wordmark
                    if (isDesktop)
                      Semantics(
                        label: l10n.brandLogoSemantics,
                        button: true,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () => onNavigateToSection(
                              LandingNavCatalog.heroId,
                            ),
                            child: const SustinaBrandLogo(
                              logoSize: 32,
                              wordmarkFontSize: 19,
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Semantics(
                            label: l10n.brandLogoSemantics,
                            button: true,
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () => onNavigateToSection(
                                  LandingNavCatalog.heroId,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: SustinaBrandLogo(
                                    logoSize: isMobile ? 28 : 32,
                                    wordmarkFontSize: isMobile ? 16.5 : 19,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    SizedBox(width: isLargeDesktop ? 16 : (isMobile ? 6 : 10)),

                    // 2. Center Section Navigation Items (Desktop >= 1024px)
                    if (isDesktop)
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 0; i < navItems.length; i++) ...[
                                  _HeaderNavItem(
                                    item: navItems[i],
                                    isActive:
                                        activeSectionId ==
                                        navItems[i].sectionId,
                                    compact: !isLargeDesktop,
                                    onTap: () => onNavigateToSection(
                                      navItems[i].sectionId,
                                    ),
                                  ),
                                  if (i < navItems.length - 1)
                                    SizedBox(width: navGap),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),

                    if (isDesktop) SizedBox(width: isLargeDesktop ? 16 : 8),

                    // 3. Action Controls: Language, Theme, Sign In / Drawer
                    _LanguageSelectorPill(
                      isArabic: isArabic,
                      compact: !isDesktop,
                      onToggle: () =>
                          context.read<LocaleCubit>().toggleLocale(),
                    ),
                    SizedBox(width: isMobile ? 6 : 8),

                    _HeaderThemeSwitcher(
                      isDark: isDark,
                      tooltip: l10n.themeModeTooltip,
                      onToggle: () => context.read<ThemeCubit>().toggleTheme(),
                    ),

                    if (isDesktop) ...[
                      const SizedBox(width: 10),
                      _HeaderLoginButton(
                        label: l10n.navLogin,
                        onTap: () => context.go(Routes.login),
                      ),
                    ] else ...[
                      const SizedBox(width: 4),
                      IconButton(
                        constraints: const BoxConstraints(
                          minWidth: 38,
                          minHeight: 38,
                        ),
                        padding: const EdgeInsets.all(6),
                        icon: Icon(
                          Icons.menu_rounded,
                          color: colors.neutral900,
                          size: 23,
                        ),
                        onPressed: onOpenDrawer,
                        tooltip: l10n.navOpenDrawer,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderNavItem extends StatefulWidget {
  const _HeaderNavItem({
    required this.item,
    required this.isActive,
    required this.compact,
    required this.onTap,
  });

  final LandingNavItem item;
  final bool isActive;
  final bool compact;
  final VoidCallback onTap;

  @override
  State<_HeaderNavItem> createState() => _HeaderNavItemState();
}

class _HeaderNavItemState extends State<_HeaderNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final highlighted = widget.isActive || _isHovered;

    final activeColor = isDark ? colors.primary700 : colors.primary600;
    final idleColor = colors.neutral700;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 9 : 12,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: widget.isActive
                ? colors.primary500.withValues(alpha: isDark ? 0.18 : 0.10)
                : (_isHovered
                      ? colors.primary500.withValues(alpha: isDark ? 0.10 : 0.05)
                      : colors.white.withValues(alpha: 0)),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.isActive) ...[
                    SustinaSvgIcon(
                      assetPath: widget.item.svgIconPath,
                      size: 14,
                      color: activeColor,
                    ),
                    const SizedBox(width: 5),
                  ],
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 180),
                    style: AppTextStyles.font13Regular.copyWith(
                      fontSize: widget.compact ? 12.5 : 13,
                      fontWeight: widget.isActive
                          ? FontWeight.w800
                          : (_isHovered ? FontWeight.w700 : FontWeight.w600),
                      color: highlighted ? activeColor : idleColor,
                    ),
                    child: Text(widget.item.label),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                height: 2.5,
                width: widget.isActive ? 22 : (_isHovered ? 12 : 0),
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageSelectorPill extends StatefulWidget {
  const _LanguageSelectorPill({
    required this.isArabic,
    required this.compact,
    required this.onToggle,
  });

  final bool isArabic;
  final bool compact;
  final VoidCallback onToggle;

  @override
  State<_LanguageSelectorPill> createState() => _LanguageSelectorPillState();
}

class _LanguageSelectorPillState extends State<_LanguageSelectorPill> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;

    return Tooltip(
      message: l10n.langSwitchTooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onToggle,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(
              horizontal: widget.compact ? 8 : 11,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: _isHovered
                  ? (isDark ? colors.grey200 : colors.grey100)
                  : (isDark ? colors.grey100 : colors.grey50),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _isHovered ? colors.primary500 : colors.grey200,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language_rounded,
                  size: 15,
                  color: isDark ? colors.primary700 : colors.primary600,
                ),
                const SizedBox(width: 5),
                Text(
                  widget.compact
                      ? (widget.isArabic ? 'EN' : 'AR')
                      : (widget.isArabic ? l10n.langNameAr : l10n.langNameEn),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: colors.neutral900,
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

class _HeaderThemeSwitcher extends StatelessWidget {
  const _HeaderThemeSwitcher({
    required this.isDark,
    required this.tooltip,
    required this.onToggle,
  });

  final bool isDark;
  final String tooltip;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: colors.grey100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.grey200),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: !isDark
                        ? colors.white
                        : colors.white.withValues(alpha: 0),
                    shape: BoxShape.circle,
                    boxShadow: !isDark
                        ? [
                            BoxShadow(
                              color: colors.black.withValues(alpha: 0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.wb_sunny_rounded,
                    size: 14,
                    color: !isDark ? colors.warning500 : colors.grey500,
                  ),
                ),
                const SizedBox(width: 2),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: isDark
                        ? colors.primary400
                        : colors.white.withValues(alpha: 0),
                    shape: BoxShape.circle,
                    boxShadow: isDark
                        ? [
                            BoxShadow(
                              color: colors.black.withValues(alpha: 0.25),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.nightlight_round,
                    size: 14,
                    color: isDark ? colors.neutral900 : colors.grey500,
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

class _HeaderLoginButton extends StatefulWidget {
  const _HeaderLoginButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  State<_HeaderLoginButton> createState() => _HeaderLoginButtonState();
}

class _HeaderLoginButtonState extends State<_HeaderLoginButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    final bgColor = isDark
        ? (_isHovered ? colors.primary700 : colors.primary600)
        : (_isHovered ? colors.primary700 : colors.primary500);
    final fgColor = colors.grey0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          transform: _isHovered
              ? Matrix4.translationValues(0, -1, 0)
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: colors.primary500.withValues(
                  alpha: _isHovered ? 0.30 : 0.16,
                ),
                blurRadius: _isHovered ? 12 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.login_rounded, size: 15, color: fgColor),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: AppTextStyles.font12Bold.copyWith(
                  fontSize: 12.5,
                  color: fgColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
