import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingWorkflowSection extends StatefulWidget {
  const LandingWorkflowSection({super.key});

  @override
  State<LandingWorkflowSection> createState() => _LandingWorkflowSectionState();
}

class _LandingWorkflowSectionState extends State<LandingWorkflowSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _beamController;
  int? _hoveredStep;

  @override
  void initState() {
    super.initState();
    _beamController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat();
  }

  @override
  void dispose() {
    _beamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;
    final isTablet = context.isTablet;
    final isDark = context.isDarkMode;
    final isRtl = context.isRtl;
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final steps = [
      _WorkflowStepData(
        number: l10n.step1Num,
        svgIconPath: AppIcons.documentUploadIcon,
        title: l10n.step1Title,
        description: l10n.step1Desc,
        accentColor: isDark ? colors.primary600 : colors.primary500,
      ),
      _WorkflowStepData(
        number: l10n.step2Num,
        svgIconPath: AppIcons.task,
        title: l10n.step2Title,
        description: l10n.step2Desc,
        accentColor: colors.secondary500,
      ),
      _WorkflowStepData(
        number: l10n.step3Num,
        svgIconPath: AppIcons.data,
        title: l10n.step3Title,
        description: l10n.step3Desc,
        accentColor: colors.info700,
      ),
      _WorkflowStepData(
        number: l10n.step4Num,
        svgIconPath: AppIcons.report,
        title: l10n.step4Title,
        description: l10n.step4Desc,
        accentColor: isDark ? colors.primary700 : colors.primary600,
      ),
    ];

    return Container(
      width: double.infinity,
      color: colors.background,
      child: AdaptiveContentContainer(
        padding: EdgeInsets.symmetric(
          vertical: context.responsiveValue<double>(
            mobile: 52,
            tablet: 68,
            desktop: 88,
          ),
          horizontal: ResponsivePadding.pageHorizontal(context),
        ),
        child: Column(
          children: [
            SustinaSectionHeader(
              category: l10n.workflowCategory,
              title: l10n.workflowTitle,
              subtitle: l10n.workflowSubtitle,
              badgeSvgPath: AppIcons.productionProcess,
              useSecondaryAccent: true,
            ),
            SizedBox(height: context.responsiveValue(mobile: 32, desktop: 52)),

            if (isDesktop)
              Stack(
                children: [
                  // Animated Flow Connector Beam across Step Badges
                  Positioned(
                    top: 46,
                    left: 80,
                    right: 80,
                    height: 6,
                    child: RepaintBoundary(
                      child: AnimatedBuilder(
                        animation: _beamController,
                        builder: (context, _) {
                          return CustomPaint(
                            painter: _WorkflowBeamPainter(
                              progress: disableAnimations
                                  ? 0.5
                                  : _beamController.value,
                              isRtl: isRtl,
                              trackColor: colors.grey200,
                              beamColor: colors.primary500,
                              goldColor: colors.secondary500,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (int i = 0; i < steps.length; i++) ...[
                          Expanded(
                            child: AppRevealAnimation(
                              delay: Duration(milliseconds: 90 * i),
                              child: _WorkflowStepCard(
                                step: steps[i],
                                stepLabel: l10n.workflowStepLabel,
                                isHovered: _hoveredStep == i,
                                onHoverChanged: (hovered) {
                                  setState(() {
                                    _hoveredStep = hovered ? i : null;
                                  });
                                },
                              ),
                            ),
                          ),
                          if (i < steps.length - 1) const SizedBox(width: 18),
                        ],
                      ],
                    ),
                  ),
                ],
              )
            else if (isTablet)
              Column(
                children: [
                  for (int row = 0; row < 2; row++) ...[
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: AppRevealAnimation(
                              delay: Duration(milliseconds: 80 * (row * 2)),
                              child: _WorkflowStepCard(
                                step: steps[row * 2],
                                stepLabel: l10n.workflowStepLabel,
                                isHovered: _hoveredStep == row * 2,
                                onHoverChanged: (hovered) {
                                  setState(() {
                                    _hoveredStep = hovered ? row * 2 : null;
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: AppRevealAnimation(
                              delay: Duration(milliseconds: 80 * (row * 2 + 1)),
                              child: _WorkflowStepCard(
                                step: steps[row * 2 + 1],
                                stepLabel: l10n.workflowStepLabel,
                                isHovered: _hoveredStep == row * 2 + 1,
                                onHoverChanged: (hovered) {
                                  setState(() {
                                    _hoveredStep = hovered ? row * 2 + 1 : null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (row == 0) const SizedBox(height: 18),
                  ],
                ],
              )
            else
              Column(
                children: [
                  for (int i = 0; i < steps.length; i++) ...[
                    AppRevealAnimation(
                      delay: Duration(milliseconds: 70 * i),
                      child: _WorkflowStepCard(
                        step: steps[i],
                        stepLabel: l10n.workflowStepLabel,
                        isHovered: _hoveredStep == i,
                        onHoverChanged: (hovered) {
                          setState(() {
                            _hoveredStep = hovered ? i : null;
                          });
                        },
                      ),
                    ),
                    if (i < steps.length - 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          width: 2.5,
                          height: 18,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                steps[i].accentColor.withValues(alpha: 0.7),
                                steps[i + 1].accentColor.withValues(alpha: 0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _WorkflowStepData {
  const _WorkflowStepData({
    required this.number,
    required this.svgIconPath,
    required this.title,
    required this.description,
    required this.accentColor,
  });

  final String number;
  final String svgIconPath;
  final String title;
  final String description;
  final Color accentColor;
}

class _WorkflowStepCard extends StatelessWidget {
  const _WorkflowStepCard({
    required this.step,
    required this.stepLabel,
    required this.isHovered,
    required this.onHoverChanged,
  });

  final _WorkflowStepData step;
  final String stepLabel;
  final bool isHovered;
  final ValueChanged<bool> onHoverChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => onHoverChanged(true),
      onExit: (_) => onHoverChanged(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, isHovered ? -5 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isHovered
                ? step.accentColor.withValues(alpha: 0.8)
                : colors.grey200,
            width: isHovered ? 1.6 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? step.accentColor.withValues(alpha: isDark ? 0.22 : 0.14)
                  : colors.black.withValues(alpha: isDark ? 0.24 : 0.04),
              blurRadius: isHovered ? 26 : 14,
              offset: Offset(0, isHovered ? 9 : 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step Icon & Number Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isHovered
                        ? step.accentColor
                        : step.accentColor.withValues(
                            alpha: isDark ? 0.18 : 0.12,
                          ),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: step.accentColor.withValues(alpha: 0.3),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SustinaSvgIcon(
                    assetPath: step.svgIconPath,
                    size: 23,
                    color: isHovered ? colors.grey0 : step.accentColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      stepLabel,
                      style: AppTextStyles.font11SemiBold.copyWith(
                        color: colors.neutral600,
                      ),
                    ),
                    Text(
                      step.number,
                      style: AppTextStyles.font28Bold.copyWith(
                        fontWeight: FontWeight.w900,
                        color: isHovered
                            ? step.accentColor
                            : (isDark ? colors.grey400 : colors.grey300),
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              step.title,
              style: AppTextStyles.font18Bold.copyWith(
                fontSize: 17,
                color: colors.neutral900,
              ),
            ),
            const SizedBox(height: 10),

            Text(
              step.description,
              style: AppTextStyles.font13Regular.copyWith(
                fontSize: 13.5,
                color: colors.neutral700,
                height: 1.58,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkflowBeamPainter extends CustomPainter {
  _WorkflowBeamPainter({
    required this.progress,
    required this.isRtl,
    required this.trackColor,
    required this.beamColor,
    required this.goldColor,
  });

  final double progress;
  final bool isRtl;
  final Color trackColor;
  final Color beamColor;
  final Color goldColor;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height / 2;
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(0, y), Offset(size.width, y), trackPaint);

    final headFraction = isRtl ? (1.0 - progress) : progress;
    final headX = headFraction * size.width;
    final tailLen = math.min(90.0, size.width * 0.22);
    final tailStart = isRtl ? headX + tailLen : headX - tailLen;

    final pulsePaint = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..shader = LinearGradient(
        colors: [
          beamColor.withValues(alpha: 0.0),
          beamColor.withValues(alpha: 0.85),
          goldColor,
        ],
        begin: isRtl ? Alignment.centerRight : Alignment.centerLeft,
        end: isRtl ? Alignment.centerLeft : Alignment.centerRight,
      ).createShader(
        Rect.fromLTRB(
          math.min(tailStart, headX),
          y - 2,
          math.max(tailStart, headX),
          y + 2,
        ),
      );

    canvas.drawLine(Offset(tailStart, y), Offset(headX, y), pulsePaint);
    canvas.drawCircle(
      Offset(headX, y),
      5.5,
      Paint()..color = goldColor.withValues(alpha: 0.25),
    );
    canvas.drawCircle(
      Offset(headX, y),
      2.6,
      Paint()..color = goldColor,
    );
  }

  @override
  bool shouldRepaint(covariant _WorkflowBeamPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isRtl != isRtl ||
        oldDelegate.trackColor != trackColor;
  }
}
