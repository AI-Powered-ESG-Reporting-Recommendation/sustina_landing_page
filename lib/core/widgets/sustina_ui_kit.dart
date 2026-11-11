import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';

/// Sustina logo mark paired with crisp wordmark, adapting automatically
/// between dark-surface (`logoSplash`) and light-surface (`logo`) variants.
class SustinaBrandLogo extends StatelessWidget {
  const SustinaBrandLogo({
    super.key,
    this.logoSize = 34,
    this.showWordmark = true,
    this.forceLightOnDark = false,
    this.wordmarkFontSize = 20,
  });

  final double logoSize;
  final bool showWordmark;
  final bool forceLightOnDark;
  final double wordmarkFontSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDarkSurface = forceLightOnDark || context.isDarkMode;
    final assetPath = isDarkSurface ? AppImages.logoSplash : AppImages.logo;
    final textColor = forceLightOnDark && !context.isDarkMode
        ? colors.grey0
        : colors.neutral900;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetPath,
          width: logoSize,
          height: logoSize,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.eco_rounded,
              color: colors.primary500,
              size: logoSize * 0.85,
            );
          },
        ),
        if (showWordmark) ...[
          const SizedBox(width: 9),
          Text(
            'Sustina',
            style: AppTextStyles.font20Bold.copyWith(
              fontSize: wordmarkFontSize,
              fontWeight: FontWeight.w900,
              color: textColor,
              letterSpacing: 0.3,
              height: 1.1,
            ),
          ),
        ],
      ],
    );
  }
}

/// Renders one of the brand SVG icons from `assets/icons/` with optional theme tinting.
class SustinaSvgIcon extends StatelessWidget {
  const SustinaSvgIcon({
    super.key,
    required this.assetPath,
    this.size = 22,
    this.color,
    this.fallbackIcon = Icons.eco_rounded,
  });

  final String assetPath;
  final double size;
  final Color? color;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      placeholderBuilder: (_) => Icon(
        fallbackIcon,
        size: size,
        color: color,
      ),
    );
  }
}

/// Consistent, reveal-animated section header with eyebrow pill, title, and subtitle.
class SustinaSectionHeader extends StatelessWidget {
  const SustinaSectionHeader({
    super.key,
    required this.category,
    required this.title,
    required this.subtitle,
    this.badgeIcon,
    this.badgeSvgPath,
    this.useSecondaryAccent = false,
    this.maxSubtitleWidth = 700,
  });

  final String category;
  final String title;
  final String subtitle;
  final IconData? badgeIcon;
  final String? badgeSvgPath;
  final bool useSecondaryAccent;
  final double maxSubtitleWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    final pillBg = useSecondaryAccent
        ? (isDark
              ? colors.secondary500.withValues(alpha: 0.14)
              : colors.secondary100)
        : (isDark
              ? colors.primary500.withValues(alpha: 0.14)
              : colors.primary100);
    final pillBorder = useSecondaryAccent
        ? (isDark
              ? colors.secondary500.withValues(alpha: 0.36)
              : colors.secondary300)
        : (isDark
              ? colors.primary500.withValues(alpha: 0.36)
              : colors.primary300);
    final pillFg = useSecondaryAccent
        ? (isDark ? colors.secondary600 : colors.secondary700)
        : (isDark ? colors.primary700 : colors.primary600);

    return AppRevealAnimation(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: pillBg,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: pillBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (badgeSvgPath != null) ...[
                  SustinaSvgIcon(
                    assetPath: badgeSvgPath!,
                    size: 15,
                    color: pillFg,
                  ),
                  const SizedBox(width: 7),
                ] else if (badgeIcon != null) ...[
                  Icon(badgeIcon, size: 15, color: pillFg),
                  const SizedBox(width: 7),
                ],
                Text(
                  category,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: pillFg,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 820),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.font32Bold.copyWith(
                fontSize: context.responsiveValue<double>(
                  mobile: 24,
                  tablet: 30,
                  desktop: 35,
                  largeDesktop: 38,
                ),
                fontWeight: FontWeight.w800,
                color: colors.neutral900,
                height: 1.28,
              ),
            ),
          ),
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxSubtitleWidth),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Regular.copyWith(
                fontSize: context.responsiveValue<double>(
                  mobile: 14,
                  tablet: 15,
                  desktop: 16,
                ),
                color: colors.neutral700,
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Primary emerald gradient button with hover lift, glow, and loading support.
class SustinaPrimaryButton extends StatefulWidget {
  const SustinaPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.showDirectionalArrow = true,
    this.isLoading = false,
    this.loadingLabel,
    this.fullWidth = false,
    this.padding,
    this.borderRadius = 30,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool showDirectionalArrow;
  final bool isLoading;
  final String? loadingLabel;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  @override
  State<SustinaPrimaryButton> createState() => _SustinaPrimaryButtonState();
}

class _SustinaPrimaryButtonState extends State<SustinaPrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final isRtl = context.isRtl;
    final isDisabled = widget.onPressed == null || widget.isLoading;

    final startColor = isDark ? colors.primary600 : colors.primary500;
    final endColor = isDark ? colors.primary700 : colors.primary700;
    final fgColor = colors.grey0;

    final effectivePadding = widget.padding ??
        const EdgeInsets.symmetric(horizontal: 26, vertical: 14);

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: isDisabled ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: widget.fullWidth ? double.infinity : null,
          transform: (_isHovered && !isDisabled)
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          padding: effectivePadding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDisabled
                  ? [
                      startColor.withValues(alpha: 0.65),
                      endColor.withValues(alpha: 0.65),
                    ]
                  : [
                      _isHovered ? endColor : startColor,
                      endColor,
                    ],
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: colors.primary500.withValues(
                  alpha: (_isHovered && !isDisabled)
                      ? (isDark ? 0.34 : 0.30)
                      : (isDark ? 0.20 : 0.18),
                ),
                blurRadius: (_isHovered && !isDisabled) ? 22 : 12,
                offset: Offset(0, (_isHovered && !isDisabled) ? 7 : 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading) ...[
                SizedBox(
                  width: 17,
                  height: 17,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.2,
                    valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.loadingLabel ?? widget.label,
                  style: AppTextStyles.font14Bold.copyWith(
                    fontSize: 15,
                    color: fgColor,
                  ),
                ),
              ] else ...[
                if (widget.icon != null) ...[
                  Icon(widget.icon, color: fgColor, size: 18),
                  const SizedBox(width: 9),
                ],
                Flexible(
                  child: Text(
                    widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14Bold.copyWith(
                      fontSize: 15,
                      color: fgColor,
                    ),
                  ),
                ),
                if (widget.showDirectionalArrow) ...[
                  const SizedBox(width: 9),
                  Icon(
                    isRtl
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_forward_rounded,
                    color: fgColor,
                    size: 18,
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Outlined glassmorphic secondary button with smooth hover tint.
class SustinaSecondaryButton extends StatefulWidget {
  const SustinaSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.svgIconPath,
    this.fullWidth = false,
    this.padding,
    this.borderRadius = 30,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? svgIconPath;
  final bool fullWidth;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  @override
  State<SustinaSecondaryButton> createState() => _SustinaSecondaryButtonState();
}

class _SustinaSecondaryButtonState extends State<SustinaSecondaryButton> {
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
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: widget.fullWidth ? double.infinity : null,
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          decoration: BoxDecoration(
            color: _isHovered
                ? colors.primary500.withValues(alpha: isDark ? 0.16 : 0.08)
                : colors.white.withValues(alpha: isDark ? 0.78 : 0.92),
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered
                  ? colors.primary500
                  : colors.grey300.withValues(alpha: isDark ? 0.8 : 0.9),
              width: 1.3,
            ),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: isDark ? 0.22 : 0.04),
                blurRadius: _isHovered ? 14 : 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.svgIconPath != null) ...[
                SustinaSvgIcon(
                  assetPath: widget.svgIconPath!,
                  size: 17,
                  color: colors.primary600,
                ),
                const SizedBox(width: 8),
              ] else if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: isDark ? colors.primary700 : colors.primary600,
                  size: 18,
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font14Bold.copyWith(
                    fontSize: 14.5,
                    color: colors.neutral900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shared themed text form field with external label, prefix icon, and validation styling.
class SustinaFormField extends StatelessWidget {
  const SustinaFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isRequired = true,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.prefixSvgPath,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final String? prefixSvgPath;
  final bool isRequired;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int maxLines;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label, isRequired: isRequired),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          style: AppTextStyles.font14Medium.copyWith(
            color: colors.neutral900,
          ),
          decoration: _sustinaInputDecoration(
            context,
            hint: hint,
            prefixIcon: prefixIcon,
            prefixSvgPath: prefixSvgPath,
            isDark: isDark,
            alignIconTop: maxLines > 1,
          ),
        ),
      ],
    );
  }
}

/// Shared themed dropdown field with external label and consistent validation styling.
class SustinaDropdownField<T> extends StatelessWidget {
  const SustinaDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.prefixIcon,
    this.prefixSvgPath,
    this.isRequired = true,
    this.validator,
  });

  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final IconData prefixIcon;
  final String? prefixSvgPath;
  final bool isRequired;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label, isRequired: isRequired),
        const SizedBox(height: 8),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
          dropdownColor: colors.white,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colors.neutral600,
          ),
          style: AppTextStyles.font14Medium.copyWith(
            color: colors.neutral900,
          ),
          decoration: _sustinaInputDecoration(
            context,
            hint: hint,
            prefixIcon: prefixIcon,
            prefixSvgPath: prefixSvgPath,
            isDark: isDark,
          ),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label, required this.isRequired});

  final String label;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.font14SemiBold.copyWith(
              fontSize: 13.5,
              color: colors.neutral800,
            ),
          ),
        ),
        if (isRequired) ...[
          const SizedBox(width: 4),
          Text(
            '*',
            style: AppTextStyles.font14Bold.copyWith(
              color: colors.error700,
            ),
          ),
        ],
      ],
    );
  }
}

InputDecoration _sustinaInputDecoration(
  BuildContext context, {
  required String hint,
  required IconData prefixIcon,
  String? prefixSvgPath,
  required bool isDark,
  bool alignIconTop = false,
}) {
  final colors = context.customAppColors;
  final iconColor = isDark ? colors.primary600 : colors.primary500;

  return InputDecoration(
    hintText: hint,
    hintStyle: AppTextStyles.font14Regular.copyWith(
      fontSize: 13.5,
      color: colors.grey500,
    ),
    filled: true,
    fillColor: isDark ? colors.grey100 : colors.grey50,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 14,
      vertical: alignIconTop ? 14 : 13,
    ),
    prefixIcon: alignIconTop
        ? null
        : Padding(
            padding: const EdgeInsetsDirectional.only(start: 12, end: 10),
            child: prefixSvgPath != null
                ? SustinaSvgIcon(
                    assetPath: prefixSvgPath,
                    size: 18,
                    color: iconColor,
                    fallbackIcon: prefixIcon,
                  )
                : Icon(prefixIcon, size: 19, color: iconColor),
          ),
    prefixIconConstraints: alignIconTop
        ? null
        : const BoxConstraints(minWidth: 42, minHeight: 24),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.grey200, width: 1.2),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.grey200, width: 1.2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.primary500, width: 1.6),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.error700, width: 1.3),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: colors.error700, width: 1.6),
    ),
    errorStyle: AppTextStyles.font12Regular.copyWith(
      color: colors.error700,
    ),
  );
}

/// Shared localized lookup lists for Demo Booking & Company Registration forms.
class SustinaFormCatalog {
  const SustinaFormCatalog._();

  static List<(String id, String label)> industries(AppLocalizations l10n) => [
        ('manufacturing', l10n.sectorManufacturing),
        ('energy', l10n.sectorEnergy),
        ('real_estate', l10n.sectorRealEstate),
        ('logistics', l10n.sectorLogistics),
        ('finance', l10n.sectorFinance),
        ('retail', l10n.sectorRetail),
        ('healthcare', l10n.sectorHealthcare),
        ('technology', l10n.sectorTechnology),
        ('other', l10n.sectorOther),
      ];

  static List<(String id, String label)> companySizes(AppLocalizations l10n) => [
        ('1-50', l10n.sizeSmall),
        ('51-250', l10n.sizeMedium),
        ('251-1000', l10n.sizeLarge),
        ('1000+', l10n.sizeEnterprise),
      ];

  static List<(String id, String label)> countries(AppLocalizations l10n) => [
        ('sa', l10n.countrySaudi),
        ('eg', l10n.countryEgypt),
        ('ae', l10n.countryUae),
        ('qa', l10n.countryQatar),
        ('kw', l10n.countryKuwait),
        ('bh', l10n.countryBahrain),
        ('om', l10n.countryOman),
        ('jo', l10n.countryJordan),
        ('other', l10n.countryOther),
      ];

  static String labelFor(List<(String id, String label)> list, String? id) {
    if (id == null) return '';
    for (final entry in list) {
      if (entry.$1 == id) return entry.$2;
    }
    return id;
  }
}

/// Animated success banner icon featuring the branded `assets/icons/done.svg`.
class SustinaSuccessGraphic extends StatelessWidget {
  const SustinaSuccessGraphic({super.key, this.size = 112});

  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            colors.primary500.withValues(alpha: isDark ? 0.30 : 0.16),
            colors.primary500.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(isDark ? 14 : 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? colors.primary800 : colors.white.withValues(alpha: 0),
          boxShadow: isDark
              ? [
                  BoxShadow(
                    color: colors.primary500.withValues(alpha: 0.35),
                    blurRadius: 24,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: SvgPicture.asset(
          AppIcons.done,
          width: isDark ? size * 0.82 : size,
          height: (isDark ? size * 0.82 : size) * 0.84,
          fit: BoxFit.contain,
          placeholderBuilder: (_) => Icon(
            Icons.check_circle_rounded,
            size: size * 0.7,
            color: colors.primary500,
          ),
        ),
      ),
    );
  }
}

