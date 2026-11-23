import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final isArabic = context.isArabic;

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
    final activeStageIndex = isSubmitted ? 2 : 1;

    return Container(
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSubmitted
              ? colors.primary500.withValues(alpha: 0.5)
              : colors.grey200,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.32 : 0.05),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline Header
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colors.primary100,
                      colors.secondary100.withValues(alpha: 0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: colors.primary500.withValues(alpha: 0.25),
                  ),
                ),
                alignment: Alignment.center,
                child: SustinaSvgIcon(
                  assetPath: AppIcons.productionProcess,
                  size: 22,
                  color: isDark ? colors.primary700 : colors.primary600,
                ),
              ),
              const SizedBox(width: 14),
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
                    const SizedBox(height: 2),
                    Text(
                      l10n.regTimelineSubtitle,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.neutral600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Progress Ratio Header & Animated Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isArabic
                    ? 'المرحلة $activeStageIndex من 6'
                    : 'Stage $activeStageIndex of 6',
                style: AppTextStyles.font12Bold.copyWith(
                  color: isDark ? colors.primary700 : colors.primary600,
                ),
              ),
              Text(
                '${(progressRatio * 100).toInt()}%',
                style: AppTextStyles.font12Bold.copyWith(
                  color: colors.neutral700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progressRatio),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  value: value,
                  minHeight: 8,
                  backgroundColor: colors.grey100,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isSubmitted ? colors.primary500 : colors.secondary500,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 26),

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

          const SizedBox(height: 16),
          Divider(color: colors.grey200, height: 28),

          // Institutional Trust & Support Box
          _EnterpriseTrustBox(isDark: isDark, isArabic: isArabic),
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
          isDark ? colors.grey100 : colors.grey50,
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
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: badgeBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: borderColor, width: 1.8),
                  boxShadow: isHighlighted
                      ? [
                          BoxShadow(
                            color: borderColor.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: status == _StageStatus.completed
                    ? Icon(Icons.check_rounded, size: 20, color: badgeFg)
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
          const SizedBox(width: 16),

          // Right Stage Details Card
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 320),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: status == _StageStatus.active
                      ? (isDark
                          ? colors.primary100.withValues(alpha: 0.4)
                          : colors.primary100.withValues(alpha: 0.5))
                      : (status == _StageStatus.next
                          ? (isDark
                              ? colors.secondary100.withValues(alpha: 0.3)
                              : colors.secondary100.withValues(alpha: 0.45))
                          : (isDark ? colors.grey100 : colors.grey50)),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: status == _StageStatus.active
                        ? colors.primary500.withValues(alpha: 0.4)
                        : (status == _StageStatus.next
                            ? colors.secondary500.withValues(alpha: 0.4)
                            : colors.grey200),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.font14Bold.copyWith(
                              color: colors.neutral900,
                              height: 1.3,
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
                              color: badgeBg.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              pillText,
                              style: AppTextStyles.font12Bold.copyWith(
                                color: borderColor,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.neutral700,
                        height: 1.45,
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

class _EnterpriseTrustBox extends StatelessWidget {
  const _EnterpriseTrustBox({
    required this.isDark,
    required this.isArabic,
  });

  final bool isDark;
  final bool isArabic;

  Future<void> _launchPhone() async {
    final uri = Uri.parse('tel:0101591764');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchEmail() async {
    final uri = Uri.parse('mailto:support@sustina.io');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? colors.grey100 : colors.grey50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.security_rounded,
                size: 18,
                color: isDark ? colors.primary700 : colors.primary600,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isArabic
                      ? 'الأمان والامتثال المؤسسي'
                      : 'Enterprise Security & Compliance',
                  style: AppTextStyles.font12Bold.copyWith(
                    color: colors.neutral900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _TrustItem(
            text: isArabic
                ? 'تشفير بيانات معتمد بتقنية 256-bit TLS'
                : '256-bit TLS institutional data encryption',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _TrustItem(
            text: isArabic
                ? 'اتفاقية سرية بيانات صارمة (NDA) للمنشآت'
                : 'Strict non-disclosure agreement (NDA) governance',
            isDark: isDark,
          ),
          const SizedBox(height: 6),
          _TrustItem(
            text: isArabic
                ? 'فريق دعم واستشارات مخصص لكل منشأة'
                : 'Dedicated ESG solution advisory & support',
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          Divider(color: colors.grey200, height: 16),
          Row(
            children: [
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: _launchPhone,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.phone_in_talk_rounded,
                          size: 14,
                          color: isDark ? colors.primary700 : colors.primary600,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '0101591764',
                          style: AppTextStyles.font12Bold.copyWith(
                            color: colors.neutral900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _launchEmail,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mail_outline_rounded,
                        size: 14,
                        color: isDark ? colors.primary700 : colors.primary600,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'support@sustina.io',
                        style: AppTextStyles.font12Bold.copyWith(
                          color: colors.neutral900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  const _TrustItem({required this.text, required this.isDark});

  final String text;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: 14,
          color: isDark ? colors.primary700 : colors.primary600,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.font12Regular.copyWith(
              color: colors.neutral700,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
