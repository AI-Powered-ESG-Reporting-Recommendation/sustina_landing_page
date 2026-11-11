import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

/// Interactive animated 6-stage onboarding timeline reflecting Sustina's
/// consultative company activation workflow.
class RegistrationStepperTimeline extends StatelessWidget {
  const RegistrationStepperTimeline({
    super.key,
    required this.isSubmitted,
  });

  /// False during Stage 1 (form entry), true once Stage 2 confirmation is active.
  final bool isSubmitted;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;

    final stages = [
      (
        '01',
        l10n.regStage1Title,
        l10n.regStage1Desc,
        AppIcons.organization,
      ),
      (
        '02',
        l10n.regStage2Title,
        l10n.regStage2Desc,
        AppIcons.done,
      ),
      (
        '03',
        l10n.regStage3Title,
        l10n.regStage3Desc,
        AppIcons.chat,
      ),
      (
        '04',
        l10n.regStage4Title,
        l10n.regStage4Desc,
        AppIcons.task,
      ),
      (
        '05',
        l10n.regStage5Title,
        l10n.regStage5Desc,
        AppIcons.carbonPricing,
      ),
      (
        '06',
        l10n.regStage6Title,
        l10n.regStage6Desc,
        AppIcons.leaf,
      ),
    ];

    final progressRatio = isSubmitted ? (2 / 6) : (1 / 6);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSubmitted
              ? colors.primary500.withValues(alpha: 0.45)
              : colors.grey200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.28 : 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? colors.primary100 : colors.primary100,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: SustinaSvgIcon(
                  assetPath: AppIcons.productionProcess,
                  size: 20,
                  color: isDark ? colors.primary700 : colors.primary600,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.regTimelineTitle,
                      style: AppTextStyles.font18Bold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                    Text(
                      l10n.regTimelineSubtitle,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.neutral600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Animated Overall Progress Indicator
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progressRatio),
            duration: const Duration(milliseconds: 550),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: value,
                      minHeight: 7,
                      backgroundColor: colors.grey100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isSubmitted ? colors.primary500 : colors.secondary500,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 22),

          // 6 Vertical Animated Stages
          for (int i = 0; i < stages.length; i++)
            _TimelineStageRow(
              index: i,
              number: stages[i].$1,
              title: stages[i].$2,
              description: stages[i].$3,
              svgIconPath: stages[i].$4,
              status: _resolveStatus(i),
              isLast: i == stages.length - 1,
            ),
        ],
      ),
    );
  }

  _StageStatus _resolveStatus(int index) {
    if (!isSubmitted) {
      return index == 0 ? _StageStatus.active : _StageStatus.upcoming;
    }
    if (index <= 1) return _StageStatus.completed;
    if (index == 2) return _StageStatus.next;
    return _StageStatus.upcoming;
  }
}

enum _StageStatus { completed, active, next, upcoming }

class _TimelineStageRow extends StatelessWidget {
  const _TimelineStageRow({
    required this.index,
    required this.number,
    required this.title,
    required this.description,
    required this.svgIconPath,
    required this.status,
    required this.isLast,
  });

  final int index;
  final String number;
  final String title;
  final String description;
  final String svgIconPath;
  final _StageStatus status;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;

    final (Color badgeBg, Color badgeFg, Color borderColor, String? pillText) =
        switch (status) {
      _StageStatus.completed => (
          colors.primary500,
          colors.grey0,
          colors.primary500,
          l10n.regStatusCompleted,
        ),
      _StageStatus.active => (
          isDark ? colors.primary200 : colors.primary100,
          isDark ? colors.primary800 : colors.primary600,
          colors.primary500,
          l10n.regStatusActive,
        ),
      _StageStatus.next => (
          isDark ? colors.secondary100 : colors.secondary100,
          isDark ? colors.secondary600 : colors.secondary700,
          colors.secondary500,
          l10n.regStatusNext,
        ),
      _StageStatus.upcoming => (
          colors.grey100,
          colors.neutral500,
          colors.grey200,
          null,
        ),
    };

    final isHighlighted = status != _StageStatus.upcoming;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Indicator Column + Vertical Connector
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: badgeBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 1.6),
                  boxShadow: isHighlighted
                      ? [
                          BoxShadow(
                            color: borderColor.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: status == _StageStatus.completed
                    ? Icon(Icons.check_rounded, size: 18, color: badgeFg)
                    : Text(
                        number,
                        style: AppTextStyles.font12Bold.copyWith(
                          color: badgeFg,
                        ),
                      ),
              ),
              if (!isLast)
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: 2.2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: status == _StageStatus.completed
                          ? colors.primary500
                          : colors.grey200,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Right Stage Details Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: status == _StageStatus.active ||
                          status == _StageStatus.next
                      ? (isDark ? colors.grey100 : colors.grey50)
                      : colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: status == _StageStatus.active ||
                            status == _StageStatus.next
                        ? borderColor.withValues(alpha: 0.45)
                        : colors.grey200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.font14Bold.copyWith(
                              color: isHighlighted
                                  ? colors.neutral900
                                  : colors.neutral700,
                            ),
                          ),
                        ),
                        if (pillText != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: status == _StageStatus.completed
                                  ? colors.primary500.withValues(alpha: 0.14)
                                  : borderColor.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              pillText,
                              style: AppTextStyles.font11SemiBold.copyWith(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: status == _StageStatus.completed
                                    ? (isDark
                                          ? colors.primary700
                                          : colors.primary600)
                                    : (status == _StageStatus.next
                                          ? (isDark
                                                ? colors.secondary600
                                                : colors.secondary700)
                                          : (isDark
                                                ? colors.primary700
                                                : colors.primary600)),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.font12Regular.copyWith(
                        fontSize: 12.5,
                        color: colors.neutral600,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

