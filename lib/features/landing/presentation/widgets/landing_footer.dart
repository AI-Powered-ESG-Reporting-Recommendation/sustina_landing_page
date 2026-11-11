import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/landing/presentation/models/landing_nav_item.dart';

class LandingFooter extends StatelessWidget {
  const LandingFooter({
    super.key,
    required this.onNavigateToSection,
  });

  final void Function(String sectionKey) onNavigateToSection;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;
    final isMobile = context.isMobile;
    final isDark = context.isDarkMode;

    // Footer sits on a rich obsidian-emerald surface in BOTH Light and Dark modes
    final footerBg = isDark ? colors.grey0 : colors.primary900;
    final onFooterTitle = isDark ? colors.neutral900 : colors.grey0;
    final onFooterBody = onFooterTitle.withValues(alpha: 0.74);
    final onFooterCaption = onFooterTitle.withValues(alpha: 0.56);
    final dividerColor = isDark
        ? colors.grey200
        : colors.primary700.withValues(alpha: 0.45);
    final goldAccent = isDark ? colors.secondary500 : colors.secondary400;

    final navItems = LandingNavCatalog.items(l10n);
    final platformLinks = [
      for (final item in navItems)
        _FooterLink(
          label: item.label,
          onTap: () => onNavigateToSection(item.sectionId),
        ),
    ];

    final portalLinks = [
      _FooterLink(
        label: l10n.footerLinkLogin,
        onTap: () => context.go(Routes.login),
      ),
      _FooterLink(
        label: l10n.footerLinkRegister,
        onTap: () => context.go(Routes.register),
      ),
      _FooterLink(
        label: l10n.footerLinkTerms,
        onTap: () => _showPolicyDialog(
          context,
          l10n.footerLinkTerms,
          l10n.footerPolicyDialogContent,
          l10n.footerCloseDialog,
        ),
      ),
      _FooterLink(
        label: l10n.footerLinkPrivacy,
        onTap: () => _showPolicyDialog(
          context,
          l10n.footerLinkPrivacy,
          l10n.footerPolicyDialogContent,
          l10n.footerCloseDialog,
        ),
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: footerBg,
        border: Border(
          top: BorderSide(color: dividerColor, width: 1),
        ),
      ),
      child: AdaptiveContentContainer(
        padding: EdgeInsets.only(
          top: isMobile ? 44 : 60,
          bottom: 28,
          left: ResponsivePadding.pageHorizontal(context),
          right: ResponsivePadding.pageHorizontal(context),
        ),
        child: Column(
          children: [
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: _BrandColumn(
                      description: l10n.footerDesc,
                      textColor: onFooterBody,
                    ),
                  ),
                  const SizedBox(width: 48),
                  Expanded(
                    flex: 2,
                    child: _LinksColumn(
                      title: l10n.footerPlatformLinks,
                      links: platformLinks,
                      titleColor: onFooterTitle,
                      linkColor: onFooterBody,
                      hoverColor: goldAccent,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: _LinksColumn(
                      title: l10n.footerPortalLinks,
                      links: portalLinks,
                      titleColor: onFooterTitle,
                      linkColor: onFooterBody,
                      hoverColor: goldAccent,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _ContactColumn(
                      title: l10n.footerContactTitle,
                      email: l10n.footerEmail,
                      team: l10n.footerContactTeam,
                      lang: l10n.footerContactLang,
                      titleColor: onFooterTitle,
                      textColor: onFooterBody,
                      iconColor: goldAccent,
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _BrandColumn(
                    description: l10n.footerDesc,
                    textColor: onFooterBody,
                  ),
                  const SizedBox(height: 28),
                  Divider(color: dividerColor),
                  const SizedBox(height: 22),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _LinksColumn(
                          title: l10n.footerPlatformLinks,
                          links: platformLinks,
                          titleColor: onFooterTitle,
                          linkColor: onFooterBody,
                          hoverColor: goldAccent,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _LinksColumn(
                          title: l10n.footerPortalLinks,
                          links: portalLinks,
                          titleColor: onFooterTitle,
                          linkColor: onFooterBody,
                          hoverColor: goldAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Divider(color: dividerColor),
                  const SizedBox(height: 20),
                  _ContactColumn(
                    title: l10n.footerContactTitle,
                    email: l10n.footerEmail,
                    team: l10n.footerContactTeam,
                    lang: l10n.footerContactLang,
                    titleColor: onFooterTitle,
                    textColor: onFooterBody,
                    iconColor: goldAccent,
                  ),
                ],
              ),

            const SizedBox(height: 40),
            Divider(color: dividerColor),
            const SizedBox(height: 20),

            Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  l10n.footerCopyright,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: onFooterCaption,
                  ),
                ),
                Text(
                  l10n.brandName,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: goldAccent,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPolicyDialog(
    BuildContext context,
    String title,
    String content,
    String closeLabel,
  ) {
    final colors = context.customAppColors;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colors.white,
        title: Text(
          title,
          style: AppTextStyles.font18Bold.copyWith(color: colors.neutral900),
        ),
        content: Text(
          content,
          style: AppTextStyles.font14Regular.copyWith(
            color: colors.neutral700,
            height: 1.6,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              closeLabel,
              style: AppTextStyles.font14Bold.copyWith(
                color: context.isDarkMode
                    ? colors.primary700
                    : colors.primary600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrandColumn extends StatelessWidget {
  const _BrandColumn({
    required this.description,
    required this.textColor,
  });

  final String description;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SustinaBrandLogo(
          logoSize: 36,
          wordmarkFontSize: 22,
          forceLightOnDark: true,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: AppTextStyles.font13Regular.copyWith(
            fontSize: 13.5,
            color: textColor,
            height: 1.65,
          ),
        ),
      ],
    );
  }
}

class _FooterLink {
  const _FooterLink({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
}

class _LinksColumn extends StatelessWidget {
  const _LinksColumn({
    required this.title,
    required this.links,
    required this.titleColor,
    required this.linkColor,
    required this.hoverColor,
  });

  final String title;
  final List<_FooterLink> links;
  final Color titleColor;
  final Color linkColor;
  final Color hoverColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.font16Bold.copyWith(
            fontSize: 15,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 16),
        for (final link in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _HoverFooterLinkText(
              label: link.label,
              idleColor: linkColor,
              hoverColor: hoverColor,
              onTap: link.onTap,
            ),
          ),
      ],
    );
  }
}

class _HoverFooterLinkText extends StatefulWidget {
  const _HoverFooterLinkText({
    required this.label,
    required this.idleColor,
    required this.hoverColor,
    required this.onTap,
  });

  final String label;
  final Color idleColor;
  final Color hoverColor;
  final VoidCallback onTap;

  @override
  State<_HoverFooterLinkText> createState() => _HoverFooterLinkTextState();
}

class _HoverFooterLinkTextState extends State<_HoverFooterLinkText> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 160),
          style: AppTextStyles.font13Regular.copyWith(
            fontSize: 13.5,
            color: _hovered ? widget.hoverColor : widget.idleColor,
            fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}

class _ContactColumn extends StatelessWidget {
  const _ContactColumn({
    required this.title,
    required this.email,
    required this.team,
    required this.lang,
    required this.titleColor,
    required this.textColor,
    required this.iconColor,
  });

  final String title;
  final String email;
  final String team;
  final String lang;
  final Color titleColor;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.font16Bold.copyWith(
            fontSize: 15,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 16),
        _ContactRow(
          icon: Icons.email_outlined,
          text: email,
          textColor: textColor,
          iconColor: iconColor,
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: Icons.support_agent_rounded,
          text: team,
          textColor: textColor,
          iconColor: iconColor,
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: Icons.language_rounded,
          text: lang,
          textColor: textColor,
          iconColor: iconColor,
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({
    required this.icon,
    required this.text,
    required this.textColor,
    required this.iconColor,
  });

  final IconData icon;
  final String text;
  final Color textColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.font13Regular.copyWith(
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
