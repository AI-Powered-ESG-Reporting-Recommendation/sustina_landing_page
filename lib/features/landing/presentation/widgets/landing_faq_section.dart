import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingFaqSection extends StatefulWidget {
  const LandingFaqSection({
    super.key,
    this.onContactPressed,
  });

  final VoidCallback? onContactPressed;

  @override
  State<LandingFaqSection> createState() => _LandingFaqSectionState();
}

class _LandingFaqSectionState extends State<LandingFaqSection> {
  // First item open by default for immediate preview
  final Set<int> _expandedIndices = {0};

  void _toggle(int index) {
    setState(() {
      if (_expandedIndices.contains(index)) {
        _expandedIndices.remove(index);
      } else {
        _expandedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    final faqItems = [
      (
        q: l10n.faqQ1,
        a: l10n.faqA1,
        icon: AppIcons.data,
      ),
      (
        q: l10n.faqQ2,
        a: l10n.faqA2,
        icon: AppIcons.chat,
      ),
      (
        q: l10n.faqQ3,
        a: l10n.faqA3,
        icon: AppIcons.productionProcess,
      ),
      (
        q: l10n.faqQ4,
        a: l10n.faqA4,
        icon: AppIcons.organization,
      ),
      (
        q: l10n.faqQ5,
        a: l10n.faqA5,
        icon: AppIcons.pending,
      ),
    ];

    return Container(
      width: double.infinity,
      color: isDark
          ? colors.background
          : colors.grey50.withValues(alpha: 0.5),
      child: AdaptiveContentContainer(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsivePadding.pageHorizontal(context),
          vertical: context.responsiveValue<double>(
            mobile: 48,
            tablet: 72,
            desktop: 88,
          ),
        ),
        child: Column(
          children: [
            AppRevealAnimation(
              child: SustinaSectionHeader(
                category: l10n.faqBadge,
                title: l10n.faqTitle,
                subtitle: l10n.faqSubtitle,
                badgeSvgPath: AppIcons.chat,
                useSecondaryAccent: false,
              ),
            ),
            SizedBox(
              height: context.responsiveValue<double>(
                mobile: 32,
                tablet: 44,
                desktop: 52,
              ),
            ),

            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                children: [
                  for (int i = 0; i < faqItems.length; i++) ...[
                    _FaqAccordionCard(
                      index: i,
                      question: faqItems[i].q,
                      answer: faqItems[i].a,
                      svgIconPath: faqItems[i].icon,
                      isExpanded: _expandedIndices.contains(i),
                      onToggle: () => _toggle(i),
                    ),
                    if (i < faqItems.length - 1) const SizedBox(height: 14),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Still have questions bottom pill banner
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 780),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 18 : 26,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: isDark ? colors.grey100 : colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colors.primary500.withValues(alpha: 0.25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.black.withValues(
                        alpha: isDark ? 0.22 : 0.04,
                      ),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: colors.primary100,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.support_agent_rounded,
                        size: 22,
                        color: isDark ? colors.primary700 : colors.primary600,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        l10n.faqStillQuestions,
                        style: AppTextStyles.font13Regular.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colors.neutral900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    TextButton.icon(
                      onPressed: widget.onContactPressed,
                      icon: Icon(
                        Icons.arrow_forward_rounded,
                        size: 16,
                        color: isDark ? colors.primary700 : colors.primary600,
                      ),
                      label: Text(
                        l10n.faqContactCta,
                        style: AppTextStyles.font14Bold.copyWith(
                          color: isDark ? colors.primary700 : colors.primary600,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        backgroundColor: colors.primary100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqAccordionCard extends StatefulWidget {
  const _FaqAccordionCard({
    required this.index,
    required this.question,
    required this.answer,
    required this.svgIconPath,
    required this.isExpanded,
    required this.onToggle,
  });

  final int index;
  final String question;
  final String answer;
  final String svgIconPath;
  final bool isExpanded;
  final VoidCallback onToggle;

  @override
  State<_FaqAccordionCard> createState() => _FaqAccordionCardState();
}

class _FaqAccordionCardState extends State<_FaqAccordionCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final isExpanded = widget.isExpanded;

    final primaryAccent = isDark ? colors.primary700 : colors.primary600;
    final cardBg = isDark
        ? (isExpanded ? colors.grey100 : colors.grey50)
        : (isExpanded ? colors.white : colors.white);

    final borderColor = isExpanded
        ? primaryAccent.withValues(alpha: isDark ? 0.6 : 0.45)
        : (_isHovered
            ? colors.grey300
            : colors.grey200);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: borderColor, width: isExpanded ? 1.4 : 1.0),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(
                  alpha: isDark
                      ? (isExpanded ? 0.32 : 0.16)
                      : (isExpanded ? 0.08 : 0.02),
                ),
                blurRadius: isExpanded ? 20 : 8,
                offset: Offset(0, isExpanded ? 6 : 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: isExpanded
                            ? primaryAccent.withValues(alpha: 0.16)
                            : colors.grey100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      alignment: Alignment.center,
                      child: SustinaSvgIcon(
                        assetPath: widget.svgIconPath,
                        size: 18,
                        color: isExpanded ? primaryAccent : colors.neutral700,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        widget.question,
                        style: AppTextStyles.font16Bold.copyWith(
                          fontSize: 15.5,
                          color: isExpanded ? primaryAccent : colors.neutral900,
                          height: 1.45,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AnimatedRotation(
                      turns: isExpanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 240),
                      curve: Curves.easeOutCubic,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isExpanded
                              ? primaryAccent.withValues(alpha: 0.12)
                              : colors.grey100,
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: isExpanded ? primaryAccent : colors.neutral700,
                        ),
                      ),
                    ),
                  ],
                ),

                // Animated Answer Body
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity, height: 0),
                  secondChild: Padding(
                    padding: const EdgeInsets.only(top: 14, left: 52, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          color: colors.grey200.withValues(alpha: 0.8),
                          height: 1,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.answer,
                          style: AppTextStyles.font14Regular.copyWith(
                            fontSize: 14,
                            color: colors.neutral700,
                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  ),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 260),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
