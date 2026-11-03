import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';

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

    return Container(
      width: double.infinity,
      color: colors.primary900,
      padding: EdgeInsets.only(
        top: isMobile ? 48 : 64,
        bottom: 28,
        left: context.responsiveValue<double>(
          mobile: 16,
          tablet: 24,
          desktop: 40,
        ),
        right: context.responsiveValue<double>(
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
              // Main Footer Columns
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Col 1: Brand Info
                    Expanded(
                      flex: 4,
                      child: _BrandColumn(description: l10n.footerDesc),
                    ),
                    const SizedBox(width: 48),

                    // Col 2: Navigation Links
                    Expanded(
                      flex: 2,
                      child: _LinksColumn(
                        title: l10n.footerPlatformLinks,
                        links: [
                          _FooterLink(label: l10n.footerLinkAbout, onTap: () => onNavigateToSection('about')),
                          _FooterLink(label: l10n.footerLinkPillars, onTap: () => onNavigateToSection('pillars')),
                          _FooterLink(label: l10n.footerLinkFeatures, onTap: () => onNavigateToSection('features')),
                          _FooterLink(label: l10n.footerLinkWorkflow, onTap: () => onNavigateToSection('workflow')),
                        ],
                      ),
                    ),

                    // Col 3: Portal Links
                    Expanded(
                      flex: 2,
                      child: _LinksColumn(
                        title: l10n.footerPortalLinks,
                        links: [
                          _FooterLink(label: l10n.footerLinkLogin, onTap: () => context.push(Routes.login)),
                          _FooterLink(label: l10n.footerLinkRegister, onTap: () => context.push(Routes.register)),
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
                        ],
                      ),
                    ),

                    // Col 4: Contact Info (from SRS)
                    Expanded(
                      flex: 3,
                      child: _ContactColumn(
                        title: l10n.footerContactTitle,
                        email: l10n.footerEmail,
                        team: l10n.footerContactTeam,
                        lang: l10n.footerContactLang,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _BrandColumn(description: l10n.footerDesc),
                    const SizedBox(height: 32),
                    Divider(color: colors.primary700.withValues(alpha: 0.35)),
                    const SizedBox(height: 24),
                    _LinksColumn(
                      title: l10n.footerPlatformLinks,
                      links: [
                        _FooterLink(label: l10n.footerLinkAbout, onTap: () => onNavigateToSection('about')),
                        _FooterLink(label: l10n.footerLinkPillars, onTap: () => onNavigateToSection('pillars')),
                        _FooterLink(label: l10n.footerLinkFeatures, onTap: () => onNavigateToSection('features')),
                        _FooterLink(label: l10n.footerLinkWorkflow, onTap: () => onNavigateToSection('workflow')),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _LinksColumn(
                      title: l10n.footerPortalLinks,
                      links: [
                        _FooterLink(label: l10n.footerLinkLogin, onTap: () => context.push(Routes.login)),
                        _FooterLink(label: l10n.footerLinkRegister, onTap: () => context.push(Routes.register)),
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
                      ],
                    ),
                    const SizedBox(height: 28),
                    Divider(color: colors.primary700.withValues(alpha: 0.35)),
                    const SizedBox(height: 20),
                    _ContactColumn(
                      title: l10n.footerContactTitle,
                      email: l10n.footerEmail,
                      team: l10n.footerContactTeam,
                      lang: l10n.footerContactLang,
                    ),
                  ],
                ),

              const SizedBox(height: 48),
              Divider(color: colors.primary700.withValues(alpha: 0.35)),
              const SizedBox(height: 24),

              // Bottom Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      l10n.footerCopyright,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ),
                  Text(
                    'AI-Powered ESG Platform',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.secondary400.withValues(alpha: 0.8),
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(
          content,
          style: const TextStyle(height: 1.6),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(closeLabel),
          ),
        ],
      ),
    );
  }
}

class _BrandColumn extends StatelessWidget {
  const _BrandColumn({required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              AppImages.logo,
              height: 38,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Text(
                'SUSTINA',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: TextStyle(
            fontSize: 13.5,
            color: Colors.white.withValues(alpha: 0.7),
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
  });

  final String title;
  final List<_FooterLink> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: link.onTap,
                child: Text(
                  link.label,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContactColumn extends StatelessWidget {
  const _ContactColumn({
    required this.title,
    required this.email,
    required this.team,
    required this.lang,
  });

  final String title;
  final String email;
  final String team;
  final String lang;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _ContactRow(
          icon: Icons.email_outlined,
          text: email,
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: Icons.support_agent_rounded,
          text: team,
        ),
        const SizedBox(height: 10),
        _ContactRow(
          icon: Icons.language_rounded,
          text: lang,
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Row(
      children: [
        Icon(icon, size: 16, color: colors.secondary400),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.72),
            ),
          ),
        ),
      ],
    );
  }
}
