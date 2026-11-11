import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suatina_web_project/core/constants/social_links.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:url_launcher/link.dart';

/// Displays Sustina's official social media links (Facebook, Instagram, LinkedIn, X)
/// using safe external anchor navigation (`target="_blank"`), hover glow animations,
/// accessible semantic labels, and theme adaptation.
class SustinaSocialLinksRow extends StatelessWidget {
  const SustinaSocialLinksRow({
    super.key,
    this.compact = false,
    this.onDarkSurface = false,
    this.spacing = 6,
  });

  final bool compact;
  final bool onDarkSurface;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = SustinaSocialCatalog.items(
      context,
      l10n,
      onDarkSurface: onDarkSurface,
    );

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final item in items)
          _SocialIconButton(
            item: item,
            compact: compact,
            onDarkSurface: onDarkSurface,
          ),
      ],
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  const _SocialIconButton({
    required this.item,
    required this.compact,
    required this.onDarkSurface,
  });

  final SustinaSocialLinkItem item;
  final bool compact;
  final bool onDarkSurface;

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final size = widget.compact ? 31.0 : 38.0;
    final iconSize = widget.compact ? 14.5 : 17.5;
    final accent = widget.item.hoverAccent;

    final Color idleBg;
    final Color idleBorder;
    final Color idleIcon;

    if (widget.onDarkSurface) {
      final baseLight = isDark ? colors.neutral900 : colors.grey0;
      idleBg = baseLight.withValues(alpha: 0.07);
      idleBorder = baseLight.withValues(alpha: 0.16);
      idleIcon = baseLight.withValues(alpha: 0.84);
    } else {
      idleBg = isDark ? colors.grey100 : colors.grey50;
      idleBorder = colors.grey200;
      idleIcon = colors.neutral700;
    }

    final Color activeBg = widget.onDarkSurface
        ? accent.withValues(alpha: 0.22)
        : accent.withValues(alpha: isDark ? 0.20 : 0.11);
    final Color activeBorder = accent.withValues(alpha: 0.68);

    return Semantics(
      label: widget.item.label,
      link: true,
      button: true,
      child: Tooltip(
        message: widget.item.label,
        child: Link(
          uri: Uri.parse(widget.item.url),
          target: LinkTarget.blank,
          builder: (context, followLink) {
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: GestureDetector(
                onTap: followLink,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  width: size,
                  height: size,
                  transform: _isHovered
                      ? Matrix4.translationValues(0, -1.5, 0)
                      : Matrix4.identity(),
                  decoration: BoxDecoration(
                    color: _isHovered ? activeBg : idleBg,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isHovered ? activeBorder : idleBorder,
                      width: 1.15,
                    ),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: accent.withValues(
                                alpha: isDark || widget.onDarkSurface
                                    ? 0.42
                                    : 0.28,
                              ),
                              blurRadius: 14,
                              spreadRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 180),
                    scale: _isHovered ? 1.10 : 1.0,
                    child: SvgPicture.string(
                      widget.item.svgMarkup,
                      width: iconSize,
                      height: iconSize,
                      colorFilter: ColorFilter.mode(
                        _isHovered ? accent : idleIcon,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

