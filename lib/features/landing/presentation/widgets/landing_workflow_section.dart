import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

class LandingWorkflowSection extends StatelessWidget {
  const LandingWorkflowSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;
    final isTablet = context.isTablet;
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
      color: isDark ? colors.background : colors.white,
      padding: EdgeInsets.symmetric(
        vertical: context.responsiveValue<double>(
          mobile: 48,
          tablet: 64,
          desktop: 80,
        ),
        horizontal: context.responsiveValue<double>(
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
              // Header
              AppRevealAnimation(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isDark
                            ? colors.secondary500.withValues(alpha: 0.15)
                            : colors.secondary100,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isDark
                              ? colors.secondary500.withValues(alpha: 0.35)
                              : colors.secondary300,
                        ),
                      ),
                      child: Text(
                        l10n.workflowCategory,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: isDark ? colors.secondary300 : colors.secondary700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n.workflowTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.responsiveValue<double>(
                          mobile: 24,
                          tablet: 30,
                          desktop: 34,
                        ),
                        fontWeight: FontWeight.w800,
                        color: colors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 680),
                      child: Text(
                        l10n.workflowSubtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15.5,
                          color: colors.neutral700,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 52),

              // Steps Layout
              if (isDesktop)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _WorkflowStepCard(
                        stepNumber: l10n.step1Num,
                        icon: Icons.upload_file_rounded,
                        title: l10n.step1Title,
                        description: l10n.step1Desc,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _WorkflowStepCard(
                        stepNumber: l10n.step2Num,
                        icon: Icons.rule_rounded,
                        title: l10n.step2Title,
                        description: l10n.step2Desc,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _WorkflowStepCard(
                        stepNumber: l10n.step3Num,
                        icon: Icons.psychology_rounded,
                        title: l10n.step3Title,
                        description: l10n.step3Desc,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: _WorkflowStepCard(
                        stepNumber: l10n.step4Num,
                        icon: Icons.assessment_rounded,
                        title: l10n.step4Title,
                        description: l10n.step4Desc,
                      ),
                    ),
                  ],
                )
              else if (isTablet)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _WorkflowStepCard(
                            stepNumber: l10n.step1Num,
                            icon: Icons.upload_file_rounded,
                            title: l10n.step1Title,
                            description: l10n.step1Desc,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _WorkflowStepCard(
                            stepNumber: l10n.step2Num,
                            icon: Icons.rule_rounded,
                            title: l10n.step2Title,
                            description: l10n.step2Desc,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _WorkflowStepCard(
                            stepNumber: l10n.step3Num,
                            icon: Icons.psychology_rounded,
                            title: l10n.step3Title,
                            description: l10n.step3Desc,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: _WorkflowStepCard(
                            stepNumber: l10n.step4Num,
                            icon: Icons.assessment_rounded,
                            title: l10n.step4Title,
                            description: l10n.step4Desc,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _WorkflowStepCard(
                      stepNumber: l10n.step1Num,
                      icon: Icons.upload_file_rounded,
                      title: l10n.step1Title,
                      description: l10n.step1Desc,
                    ),
                    const SizedBox(height: 16),
                    _WorkflowStepCard(
                      stepNumber: l10n.step2Num,
                      icon: Icons.rule_rounded,
                      title: l10n.step2Title,
                      description: l10n.step2Desc,
                    ),
                    const SizedBox(height: 16),
                    _WorkflowStepCard(
                      stepNumber: l10n.step3Num,
                      icon: Icons.psychology_rounded,
                      title: l10n.step3Title,
                      description: l10n.step3Desc,
                    ),
                    const SizedBox(height: 16),
                    _WorkflowStepCard(
                      stepNumber: l10n.step4Num,
                      icon: Icons.assessment_rounded,
                      title: l10n.step4Title,
                      description: l10n.step4Desc,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkflowStepCard extends StatelessWidget {
  const _WorkflowStepCard({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String stepNumber;
  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? colors.grey200.withValues(alpha: 0.4) : colors.grey200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step Number & Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isDark
                      ? colors.primary500.withValues(alpha: 0.15)
                      : colors.primary100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colors.primary500, size: 24),
              ),
              Text(
                stepNumber,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: isDark ? colors.grey400 : colors.grey300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: colors.neutral900,
            ),
          ),
          const SizedBox(height: 10),

          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 13.5,
              color: colors.neutral700,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}
