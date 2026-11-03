import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';

class LandingHeader extends StatelessWidget {
  const LandingHeader({
    super.key,
    required this.onNavigateToSection,
    required this.onOpenDrawer,
  });

  final void Function(String sectionKey) onNavigateToSection;
  final VoidCallback onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isRtl = context.isArabic;
    final isDark = context.isDarkMode;
    final screenW = context.screenWidth;
    final isDesktop = screenW >= 1080;

    final horizontalMargin = context.responsiveValue<double>(
      mobile: 12.0,
      tablet: 20.0,
      desktop: 28.0,
      largeDesktop: 40.0,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 14,
        bottom: 10,
        left: horizontalMargin,
        right: horizontalMargin,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.maxContentWidth,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: colors.white.withValues(alpha: isDark ? 0.88 : 0.94),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: colors.grey200.withValues(
                      alpha: isDark ? 0.35 : 0.8,
                    ),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.black.withValues(
                        alpha: isDark ? 0.35 : 0.05,
                      ),
                      blurRadius: 22,
                      offset: const Offset(0, 6),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // 1. BRAND LOGO
                    Semantics(
                      label: l10n.brandLogoSemantics,
                      button: true,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => onNavigateToSection('hero'),
                          child: SizedBox(
                            height: 34,
                            width: 120,
                            child: Image.asset(
                              AppImages.logo,
                              fit: BoxFit.contain,
                              alignment: isRtl
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              errorBuilder: (context, error, stackTrace) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.eco_rounded,
                                      color: colors.primary600,
                                      size: 22,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Sustina',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: colors.primary700,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 2. LANGUAGE SELECTOR PILL (Arabic / English)
                    _LanguageSelectorPill(
                      isRtl: isRtl,
                      onToggle: () =>
                          context.read<LocaleCubit>().toggleLocale(),
                    ),

                    const Spacer(),

                    // 3. CENTER NAVIGATION ITEMS (Desktop)
                    if (isDesktop) ...[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Home (Active with Underline Indicator)
                          _ActiveHeaderNavItem(
                            label: l10n.navHome,
                            icon: Icons.home_rounded,
                            onTap: () => onNavigateToSection('hero'),
                          ),
                          const SizedBox(width: 18),

                          // Dashboard
                          _HeaderNavLink(
                            label: l10n.navDashboard,
                            onTap: () => onNavigateToSection('pillars'),
                          ),
                          const SizedBox(width: 18),

                          // Reports
                          _HeaderNavLink(
                            label: l10n.navReports,
                            onTap: () => onNavigateToSection('workflow'),
                          ),
                          const SizedBox(width: 18),

                          // Data
                          _HeaderNavLink(
                            label: l10n.navData,
                            icon: Icons.bar_chart_rounded,
                            onTap: () => onNavigateToSection('features'),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],

                    // 4. ACTION CONTROLS (Theme Switcher, Notification, User Chip)
                    // Theme Switcher (Sun / Moon)
                    _HeaderThemeSwitcher(
                      isDark: isDark,
                      onToggle: () => context.read<ThemeCubit>().toggleTheme(),
                    ),
                    const SizedBox(width: 10),

                    // Notification Bell (Desktop)
                    if (isDesktop) ...[
                      const SizedBox(width: 12),

                      // Modern Login Button
                      _HeaderLoginButton(
                        label: l10n.navLogin,
                        onTap: () => context.go(Routes.login),
                      ),
                    ] else ...[
                      // Mobile Drawer Hamburger Button
                      IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          color: colors.neutral900,
                          size: 24,
                        ),
                        onPressed: onOpenDrawer,
                        tooltip: l10n.navHome,
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

// -----------------------------------------------------------------------------
// LANGUAGE SELECTOR PILL
// -----------------------------------------------------------------------------

class _LanguageSelectorPill extends StatelessWidget {
  const _LanguageSelectorPill({required this.isRtl, required this.onToggle});

  final bool isRtl;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onToggle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.grey200, width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language_rounded, size: 15, color: colors.neutral800),
              const SizedBox(width: 6),
              Text(
                isRtl ? 'العربية' : 'English',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colors.neutral800,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 15,
                color: colors.grey600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// ACTIVE NAV ITEM (WITH GREEN UNDERLINE)
// -----------------------------------------------------------------------------

class _ActiveHeaderNavItem extends StatelessWidget {
  const _ActiveHeaderNavItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: colors.primary700),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w800,
                    color: colors.primary700,
                    fontFamily: 'Cairo',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              height: 3,
              width: 32,
              decoration: BoxDecoration(
                color: colors.primary700,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderNavLink extends StatefulWidget {
  const _HeaderNavLink({required this.label, this.icon, required this.onTap});

  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  State<_HeaderNavLink> createState() => _HeaderNavLinkState();
}

class _HeaderNavLinkState extends State<_HeaderNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 150),
          style: TextStyle(
            fontSize: 13,
            fontWeight: _isHovered ? FontWeight.bold : FontWeight.w600,
            color: _isHovered ? colors.primary700 : colors.neutral700,
            fontFamily: 'Cairo',
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 15,
                  color: _isHovered ? colors.primary700 : colors.grey600,
                ),
                const SizedBox(width: 5),
              ],
              Text(widget.label),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderThemeSwitcher extends StatelessWidget {
  const _HeaderThemeSwitcher({required this.isDark, required this.onToggle});

  final bool isDark;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return MouseRegion(
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
              // Sun (Light mode)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: !isDark ? colors.white : Colors.transparent,
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

              // Moon (Dark mode)
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isDark ? colors.primary800 : Colors.transparent,
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
                  color: isDark ? colors.white : colors.grey500,
                ),
              ),
            ],
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

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isDark
                ? (_isHovered ? colors.primary700 : colors.primary800)
                : (_isHovered ? colors.primary800 : colors.primary900),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: isDark ? 0.30 : 0.12),
                blurRadius: _isHovered ? 10 : 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.login_rounded, size: 15, color: colors.white),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: colors.white,
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
