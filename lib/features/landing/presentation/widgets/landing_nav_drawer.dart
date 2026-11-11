import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/landing/presentation/models/landing_nav_item.dart';

class LandingNavDrawer extends StatelessWidget {
  const LandingNavDrawer({
    super.key,
    required this.activeSectionId,
    required this.onNavigateToSection,
  });

  final String activeSectionId;
  final void Function(String sectionKey) onNavigateToSection;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isRtl = context.isArabic;
    final isDark = context.isDarkMode;
    final navItems = LandingNavCatalog.items(l10n);

    return Drawer(
      backgroundColor: colors.white,
      surfaceTintColor: colors.white.withValues(alpha: 0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  const SustinaBrandLogo(
                    logoSize: 34,
                    wordmarkFontSize: 20,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: colors.neutral700),
                    tooltip: l10n.navCloseDrawer,
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: colors.grey200),

            // Navigation Links matching actual Landing Page sections
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                children: [
                  for (final item in navItems) ...[
                    _DrawerItem(
                      svgIconPath: item.svgIconPath,
                      label: item.label,
                      isActive: activeSectionId == item.sectionId,
                      onTap: () {
                        Navigator.of(context).pop();
                        onNavigateToSection(item.sectionId);
                      },
                    ),
                    const SizedBox(height: 4),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    child: Divider(height: 1, color: colors.grey200),
                  ),

                  // Language Switcher Tile
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: Icon(
                      Icons.language_rounded,
                      color: isDark ? colors.primary600 : colors.primary500,
                      size: 22,
                    ),
                    title: Text(
                      isRtl ? l10n.langNameAr : l10n.langNameEn,
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary500.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isRtl ? 'EN' : 'عربي',
                        style: AppTextStyles.font12Bold.copyWith(
                          color: isDark ? colors.primary700 : colors.primary600,
                        ),
                      ),
                    ),
                    onTap: () => context.read<LocaleCubit>().toggleLocale(),
                  ),

                  // Theme Mode Switcher Tile
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    leading: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_outlined,
                      color: isDark ? colors.secondary500 : colors.primary500,
                      size: 22,
                    ),
                    title: Text(
                      isDark ? l10n.themeLight : l10n.themeDark,
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                    trailing: Switch(
                      value: isDark,
                      activeThumbColor: colors.secondary500,
                      onChanged: (_) =>
                          context.read<ThemeCubit>().toggleTheme(),
                    ),
                    onTap: () => context.read<ThemeCubit>().toggleTheme(),
                  ),
                ],
              ),
            ),

            // Bottom Action Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SustinaPrimaryButton(
                    label: l10n.navRegister,
                    fullWidth: true,
                    borderRadius: 14,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(Routes.register);
                    },
                  ),
                  const SizedBox(height: 10),
                  SustinaSecondaryButton(
                    label: l10n.navLogin,
                    icon: Icons.login_rounded,
                    fullWidth: true,
                    borderRadius: 14,
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.go(Routes.login);
                    },
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

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.svgIconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String svgIconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final accentColor = isDark ? colors.primary700 : colors.primary600;

    return Material(
      color: isActive
          ? colors.primary500.withValues(alpha: isDark ? 0.16 : 0.10)
          : colors.white.withValues(alpha: 0),
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: SustinaSvgIcon(
          assetPath: svgIconPath,
          size: 20,
          color: isActive ? accentColor : colors.neutral600,
        ),
        title: Text(
          label,
          style: AppTextStyles.font14SemiBold.copyWith(
            fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
            color: isActive ? accentColor : colors.neutral900,
          ),
        ),
        trailing: isActive
            ? Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
