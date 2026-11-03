import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';

class LandingNavDrawer extends StatelessWidget {
  const LandingNavDrawer({
    super.key,
    required this.onNavigateToSection,
  });

  final void Function(String sectionKey) onNavigateToSection;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isRtl = context.isArabic;
    final isDark = context.isDarkMode;

    return Drawer(
      backgroundColor: colors.white,
      surfaceTintColor: Colors.transparent,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: Row(
                children: [
                  Image.asset(
                    AppImages.logo,
                    height: 38,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Text(
                      'SUSTINA',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colors.primary500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: colors.grey700),
                    tooltip: 'Close',
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Navigation Links
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerItem(
                    icon: Icons.info_outline_rounded,
                    label: l10n.navAbout,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigateToSection('about');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.pie_chart_outline_rounded,
                    label: l10n.navPillars,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigateToSection('pillars');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.auto_awesome_rounded,
                    label: l10n.navFeatures,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigateToSection('features');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.alt_route_rounded,
                    label: l10n.navWorkflow,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigateToSection('workflow');
                    },
                  ),
                  _DrawerItem(
                    icon: Icons.contact_support_outlined,
                    label: l10n.navContact,
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavigateToSection('contact');
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    child: Divider(height: 1),
                  ),

                  // Language Switcher Tile
                  ListTile(
                    leading: Icon(Icons.language_rounded, color: colors.primary500, size: 22),
                    title: Text(
                      isRtl ? 'اللغة: العربية (English)' : 'Language: English (العربية)',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: colors.neutral900,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: colors.primary500.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        isRtl ? 'EN' : 'عربي',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colors.primary600,
                        ),
                      ),
                    ),
                    onTap: () => context.read<LocaleCubit>().toggleLocale(),
                  ),

                  // Theme Mode Switcher Tile
                  ListTile(
                    leading: Icon(
                      isDark ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
                      color: isDark ? colors.secondary400 : colors.primary500,
                      size: 22,
                    ),
                    title: Text(
                      isDark ? l10n.themeLight : l10n.themeDark,
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: colors.neutral900,
                      ),
                    ),
                    trailing: Switch(
                      value: isDark,
                      activeThumbColor: colors.secondary400,
                      onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                    ),
                    onTap: () => context.read<ThemeCubit>().toggleTheme(),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.push(Routes.register);
                    },
                    icon: Icon(
                      isRtl ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
                      size: 16,
                    ),
                    label: Text(l10n.navRegister),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.primary500,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.push(Routes.login);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.primary600,
                      side: BorderSide(color: colors.primary400, width: 1.2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      l10n.navLogin,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
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
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return ListTile(
      leading: Icon(icon, color: colors.primary500, size: 22),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: colors.neutral900,
        ),
      ),
      onTap: onTap,
    );
  }
}
