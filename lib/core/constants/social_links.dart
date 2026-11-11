import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

enum SustinaSocialPlatform {
  facebook,
  instagram,
  linkedin,
  x,
}

class SustinaSocialLinkItem {
  const SustinaSocialLinkItem({
    required this.platform,
    required this.url,
    required this.label,
    required this.svgMarkup,
    required this.hoverAccent,
  });

  final SustinaSocialPlatform platform;
  final String url;
  final String label;
  final String svgMarkup;
  final Color hoverAccent;
}

class SustinaSocialCatalog {
  const SustinaSocialCatalog._();

  static const String facebookUrl = 'https://www.facebook.com/sustiina';
  static const String instagramUrl = 'https://www.instagram.com/__sustina__';
  static const String linkedinUrl =
      'https://www.linkedin.com/company/sustiina/';
  static const String xUrl = 'https://x.com/__sustina__';

  static const String _facebookSvg = '''
<svg viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M14.5 13.5H17L18 9.5H14.5V7.5C14.5 6.47 14.5 5.5 16.5 5.5H18V2.14C17.674 2.097 16.443 2 15.143 2C12.288 2 10.5 3.657 10.5 6.7V9.5H7.5V13.5H10.5V22H14.5V13.5Z"/>
</svg>
''';

  static const String _instagramSvg = '''
<svg viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M7.8 2H16.2C19.4 2 22 4.6 22 7.8V16.2C22 19.4 19.4 22 16.2 22H7.8C4.6 22 2 19.4 2 16.2V7.8C2 4.6 4.6 2 7.8 2ZM7.6 4C5.61 4 4 5.61 4 7.6V16.4C4 18.39 5.61 20 7.6 20H16.4C18.39 20 20 18.39 20 16.4V7.6C20 5.61 18.39 4 16.4 4H7.6ZM17.25 5.5C17.94 5.5 18.5 6.06 18.5 6.75C18.5 7.44 17.94 8 17.25 8C16.56 8 16 7.44 16 6.75C16 6.06 16.56 5.5 17.25 5.5ZM12 7C14.76 7 17 9.24 17 12C17 14.76 14.76 17 12 17C9.24 17 7 14.76 7 12C7 9.24 9.24 7 12 7ZM12 9C10.34 9 9 10.34 9 12C9 13.66 10.34 15 12 15C13.66 15 15 13.66 15 12C15 10.34 13.66 9 12 9Z"/>
</svg>
''';

  static const String _linkedinSvg = '''
<svg viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M6.94 8.5H3.56V19.5H6.94V8.5ZM5.25 3.5C4.14 3.5 3.25 4.39 3.25 5.5C3.25 6.6 4.14 7.5 5.25 7.5C6.35 7.5 7.25 6.6 7.25 5.5C7.25 4.39 6.35 3.5 5.25 3.5ZM20.44 13.02C20.44 9.88 18.76 8.22 16.16 8.22C14.37 8.22 13.48 9.21 13.02 9.93V8.5H9.65C9.7 9.48 9.65 19.5 9.65 19.5H13.02V13.36C13.02 13.02 13.05 12.69 13.15 12.45C13.42 11.78 14.03 11.09 15.07 11.09C16.41 11.09 17.06 12.11 17.06 13.6V19.5H20.44V13.02Z"/>
</svg>
''';

  static const String _xSvg = '''
<svg viewBox="0 0 24 24" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path d="M18.244 2.25H21.552L14.325 10.51L22.827 21.75H16.17L10.956 14.933L4.99 21.75H1.68L9.41 12.915L1.254 2.25H8.08L12.793 8.481L18.244 2.25ZM17.083 19.77H18.916L7.084 4.126H5.117L17.083 19.77Z"/>
</svg>
''';

  static List<SustinaSocialLinkItem> items(
    BuildContext context,
    AppLocalizations l10n, {
    bool onDarkSurface = false,
  }) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    // Platform brand hover colors adapted for contrast on light and dark surfaces
    final fbGlow = const Color(0xFF1877F2);
    final igGlow = const Color(0xFFE1306C);
    final lnGlow = const Color(0xFF0A66C2);
    final xGlow = (onDarkSurface || isDark)
        ? colors.neutral900
        : colors.primary900;

    return [
      SustinaSocialLinkItem(
        platform: SustinaSocialPlatform.facebook,
        url: facebookUrl,
        label: l10n.socialFacebookLabel,
        svgMarkup: _facebookSvg,
        hoverAccent: fbGlow,
      ),
      SustinaSocialLinkItem(
        platform: SustinaSocialPlatform.instagram,
        url: instagramUrl,
        label: l10n.socialInstagramLabel,
        svgMarkup: _instagramSvg,
        hoverAccent: igGlow,
      ),
      SustinaSocialLinkItem(
        platform: SustinaSocialPlatform.linkedin,
        url: linkedinUrl,
        label: l10n.socialLinkedInLabel,
        svgMarkup: _linkedinSvg,
        hoverAccent: lnGlow,
      ),
      SustinaSocialLinkItem(
        platform: SustinaSocialPlatform.x,
        url: xUrl,
        label: l10n.socialXLabel,
        svgMarkup: _xSvg,
        hoverAccent: xGlow,
      ),
    ];
  }
}
