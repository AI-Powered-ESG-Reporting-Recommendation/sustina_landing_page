import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

/// High-fidelity, real-widget Sustainability Analytics Dashboard Preview
/// faithfully reproducing the reference design with live responsive layout,
/// animated chart curve, peak KPI tooltip, sparklines, and theme adaptation.
class HeroProductPreview extends StatefulWidget {
  const HeroProductPreview({super.key});

  @override
  State<HeroProductPreview> createState() => _HeroProductPreviewState();
}

class _HeroProductPreviewState extends State<HeroProductPreview> {
  int _selectedTabIndex = 0; // 0: Monthly, 1: Quarterly, 2: Annual

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    return Container(
      decoration: BoxDecoration(
        color: colors.white.withValues(alpha: isDark ? 0.90 : 0.96),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.grey200.withValues(alpha: isDark ? 0.3 : 0.8),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.35 : 0.06),
            blurRadius: 36,
            offset: const Offset(0, 16),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: colors.primary500.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(isMobile ? 14 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Top Bar: Title with trending badge + Timeframe dropdown
          Row(
            children: [
              // Badge Icon + Title
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: colors.primary100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.trending_up_rounded,
                  color: colors.primary700,
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.dashSummaryTitle,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 15,
                    fontWeight: FontWeight.bold,
                    color: colors.neutral900,
                    fontFamily: 'Cairo',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),

              // Calendar Filter Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: colors.grey200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 13,
                      color: colors.grey600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.dashPeriodLast12Months,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: colors.neutral800,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 14,
                      color: colors.grey600,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 2. Three Top KPI Cards in a Row (or column on very narrow screens)
          LayoutBuilder(
            builder: (context, constraints) {
              final isVeryNarrow = constraints.maxWidth < 360;
              if (isVeryNarrow) {
                return Column(
                  children: [
                    _KpiCard(
                      value: '100/88',
                      title: l10n.dashKpiEsgScore,
                      icon: Icons.eco_rounded,
                      iconBg: colors.primary100,
                      iconColor: colors.primary600,
                      badgeText: '↑ 12%',
                      badgeBg: colors.primary100,
                      badgeColor: colors.primary700,
                      sparklineColor: colors.primary500,
                      sparklineData: const [0.4, 0.5, 0.45, 0.7, 0.6, 0.88],
                    ),
                    const SizedBox(height: 10),
                    _KpiCard(
                      value: '68%',
                      title: l10n.dashKpiWater,
                      icon: Icons.water_drop_rounded,
                      iconBg: colors.info300.withValues(alpha: 0.2),
                      iconColor: colors.info700,
                      badgeText: '↑ 5%',
                      badgeBg: colors.primary100,
                      badgeColor: colors.primary700,
                      sparklineColor: colors.info500,
                      sparklineData: const [0.3, 0.4, 0.5, 0.48, 0.65, 0.68],
                    ),
                    const SizedBox(height: 10),
                    _KpiCard(
                      value: '1,420',
                      title: l10n.dashKpiEmissions,
                      icon: Icons.cloud_outlined,
                      iconBg: colors.secondary100,
                      iconColor: colors.secondary700,
                      badgeText: '↓ 8%',
                      badgeBg: colors.primary100,
                      badgeColor: colors.primary700,
                      sparklineColor: colors.secondary500,
                      sparklineData: const [0.75, 0.7, 0.62, 0.58, 0.52, 0.45],
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: _KpiCard(
                      value: '100/88',
                      title: l10n.dashKpiEsgScore,
                      icon: Icons.eco_rounded,
                      iconBg: colors.primary100,
                      iconColor: colors.primary600,
                      badgeText: '↑ 12%',
                      badgeBg: colors.primary100,
                      badgeColor: colors.primary700,
                      sparklineColor: colors.primary500,
                      sparklineData: const [0.4, 0.5, 0.45, 0.7, 0.6, 0.88],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _KpiCard(
                      value: '68%',
                      title: l10n.dashKpiWater,
                      icon: Icons.water_drop_rounded,
                      iconBg: colors.info300.withValues(alpha: 0.2),
                      iconColor: colors.info700,
                      badgeText: '↑ 5%',
                      badgeBg: colors.primary100,
                      badgeColor: colors.primary700,
                      sparklineColor: colors.info500,
                      sparklineData: const [0.3, 0.4, 0.5, 0.48, 0.65, 0.68],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _KpiCard(
                      value: '1,420',
                      title: l10n.dashKpiEmissions,
                      icon: Icons.cloud_outlined,
                      iconBg: colors.secondary100,
                      iconColor: colors.secondary700,
                      badgeText: '↓ 8%',
                      badgeBg: colors.primary100,
                      badgeColor: colors.primary700,
                      sparklineColor: colors.secondary500,
                      sparklineData: const [0.75, 0.7, 0.62, 0.58, 0.52, 0.45],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),

          // 3. Main Chart Panel
          Container(
            padding: EdgeInsets.all(isMobile ? 12 : 16),
            decoration: BoxDecoration(
              color: colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Chart Title & Segmented Filter Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.bar_chart_rounded,
                          color: colors.primary600,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          l10n.dashChartTitle,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 13,
                            fontWeight: FontWeight.bold,
                            color: colors.neutral900,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ],
                    ),

                    // Filter Tabs: Monthly, Quarterly, Annual
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: colors.grey100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ChartTabPill(
                            label: l10n.dashTabMonthly,
                            isActive: _selectedTabIndex == 0,
                            onTap: () => setState(() => _selectedTabIndex = 0),
                          ),
                          _ChartTabPill(
                            label: l10n.dashTabQuarterly,
                            isActive: _selectedTabIndex == 1,
                            onTap: () => setState(() => _selectedTabIndex = 1),
                          ),
                          _ChartTabPill(
                            label: l10n.dashTabAnnual,
                            isActive: _selectedTabIndex == 2,
                            onTap: () => setState(() => _selectedTabIndex = 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Area / Line Chart with peak 92% tooltip at April
                SizedBox(
                  height: isMobile ? 140 : 170,
                  child: _SustainabilityAreaChart(
                    months: [
                      l10n.dashMonthJan,
                      l10n.dashMonthFeb,
                      l10n.dashMonthMar,
                      l10n.dashMonthApr,
                      l10n.dashMonthMay,
                      l10n.dashMonthJun,
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 4. Bottom Mint Banner: "مؤسسة مستدامة .. لمستقبل أفضل"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary100.withValues(alpha: 0.85),
                  colors.primary100.withValues(alpha: 0.35),
                ],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: colors.primary200.withValues(alpha: 0.6),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Soft decorative leaf icon
                Icon(
                  Icons.eco_outlined,
                  size: 26,
                  color: colors.primary600.withValues(alpha: 0.5),
                ),
                const SizedBox(width: 8),

                // Banner Text
                Expanded(
                  child: Text(
                    l10n.dashBannerText,
                    style: TextStyle(
                      fontSize: isMobile ? 11.5 : 12.5,
                      fontWeight: FontWeight.w700,
                      color: colors.primary900,
                      fontFamily: 'Cairo',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),

                // Arrow Action Circle Button
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colors.primary700,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    context.isArabic
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_forward_rounded,
                    color: colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// KPI CARD WIDGET
// -----------------------------------------------------------------------------

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.value,
    required this.title,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.badgeText,
    required this.badgeBg,
    required this.badgeColor,
    required this.sparklineColor,
    required this.sparklineData,
  });

  final String value;
  final String title;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String badgeText;
  final Color badgeBg;
  final Color badgeColor;
  final Color sparklineColor;
  final List<double> sparklineData;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.grey200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Circular Icon + Value
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 18),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: colors.neutral900,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w600,
              color: colors.grey600,
              fontFamily: 'Cairo',
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),

          // Bottom Row: Badge + Sparkline
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: badgeColor,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: SizedBox(
                  height: 20,
                  child: CustomPaint(
                    painter: _SparklinePainter(
                      color: sparklineColor,
                      data: sparklineData,
                    ),
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

// -----------------------------------------------------------------------------
// TAB PILL
// -----------------------------------------------------------------------------

class _ChartTabPill extends StatelessWidget {
  const _ChartTabPill({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? colors.primary900 : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? colors.white : colors.grey600,
              fontFamily: 'Cairo',
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SUSTAINABILITY AREA CHART
// -----------------------------------------------------------------------------

class _SustainabilityAreaChart extends StatelessWidget {
  const _SustainabilityAreaChart({required this.months});

  final List<String> months;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isArabic = context.isArabic;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _AreaChartPainter(
            colors: colors,
            isArabic: isArabic,
            months: months,
          ),
        );
      },
    );
  }
}

class _AreaChartPainter extends CustomPainter {
  _AreaChartPainter({
    required this.colors,
    required this.isArabic,
    required this.months,
  });

  final dynamic colors;
  final bool isArabic;
  final List<String> months;

  // Normalized Y values (0.0 to 1.0) for Jan to Jun:
  // Jan: 58%, Feb: 68%, Mar: 60%, Apr: 92% (PEAK), May: 70%, Jun: 78%
  final List<double> normalizedValues = const [0.58, 0.68, 0.60, 0.92, 0.70, 0.78];

  @override
  void paint(Canvas canvas, Size size) {
    const yAxisWidth = 28.0;
    const xAxisHeight = 22.0;

    final chartLeft = isArabic ? 10.0 : yAxisWidth;
    final chartRight = isArabic ? size.width - yAxisWidth : size.width - 10.0;
    final chartTop = 32.0; // Room for peak 92% tooltip
    final chartBottom = size.height - xAxisHeight;
    final chartWidth = chartRight - chartLeft;
    final chartHeight = chartBottom - chartTop;

    // 1. Draw Y-Axis labels (0, 25, 50, 75, 100) and horizontal grid lines
    final gridPaint = Paint()
      ..color = (colors.grey200 as Color).withValues(alpha: 0.6)
      ..strokeWidth = 0.8;

    final textStyle = TextStyle(
      color: colors.grey500 as Color,
      fontSize: 9,
      fontFamily: 'Cairo',
    );

    final ySteps = [0, 25, 50, 75, 100];
    for (int i = 0; i < ySteps.length; i++) {
      final val = ySteps[i];
      final y = chartBottom - (val / 100.0) * chartHeight;

      // Grid line
      canvas.drawLine(
        Offset(chartLeft, y),
        Offset(chartRight, y),
        gridPaint,
      );

      // Label
      final tp = TextPainter(
        text: TextSpan(text: '$val', style: textStyle),
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      )..layout();

      final labelX = isArabic ? size.width - 24 : 0.0;
      tp.paint(canvas, Offset(labelX, y - tp.height / 2));
    }

    // 2. Compute Points
    final count = normalizedValues.length;
    final points = <Offset>[];

    for (int i = 0; i < count; i++) {
      final t = i / (count - 1);
      final x = isArabic
          ? chartRight - t * chartWidth // Right to left
          : chartLeft + t * chartWidth; // Left to right
      final y = chartBottom - normalizedValues[i] * chartHeight;
      points.add(Offset(x, y));
    }

    // 3. Create Bezier Path
    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlX = (p0.dx + p1.dx) / 2;
      path.cubicTo(controlX, p0.dy, controlX, p1.dy, p1.dx, p1.dy);
    }

    // 4. Draw Gradient Fill Under the Curve
    final fillPath = Path.from(path);
    fillPath.lineTo(points.last.dx, chartBottom);
    fillPath.lineTo(points.first.dx, chartBottom);
    fillPath.close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          (colors.primary500 as Color).withValues(alpha: 0.38),
          (colors.primary500 as Color).withValues(alpha: 0.15),
          (colors.primary100 as Color).withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(chartLeft, chartTop, chartRight, chartBottom));

    canvas.drawPath(fillPath, fillPaint);

    // 5. Draw Stroke Curve
    final strokePaint = Paint()
      ..color = colors.primary600 as Color
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, strokePaint);

    // 6. Draw Data Points (Dots)
    final dotPaint = Paint()..color = colors.primary600 as Color;
    final dotInner = Paint()..color = colors.white as Color;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 3.5, dotPaint);
      canvas.drawCircle(points[i], 1.8, dotInner);
    }

    // 7. Peak Indicator at April (index 3)
    final peakPoint = points[3];

    // Dashed vertical guideline
    final dashPaint = Paint()
      ..color = (colors.primary600 as Color).withValues(alpha: 0.7)
      ..strokeWidth = 1.2;

    double curY = peakPoint.dy;
    const dashH = 4.0;
    const gapH = 3.0;
    while (curY < chartBottom) {
      final nextY = math.min(curY + dashH, chartBottom);
      canvas.drawLine(Offset(peakPoint.dx, curY), Offset(peakPoint.dx, nextY), dashPaint);
      curY += dashH + gapH;
    }

    // Active tooltip bubble at top of peak
    final tooltipWidth = 42.0;
    final tooltipHeight = 22.0;
    final tooltipRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(peakPoint.dx, peakPoint.dy - 16),
        width: tooltipWidth,
        height: tooltipHeight,
      ),
      const Radius.circular(12),
    );

    final tooltipBg = Paint()..color = colors.primary900 as Color;
    canvas.drawRRect(tooltipRect, tooltipBg);

    // Tooltip text "92%"
    final tooltipTp = TextPainter(
      text: const TextSpan(
        text: '92%',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10.5,
          fontWeight: FontWeight.w900,
          fontFamily: 'Cairo',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tooltipTp.paint(
      canvas,
      Offset(
        peakPoint.dx - tooltipTp.width / 2,
        peakPoint.dy - 16 - tooltipTp.height / 2,
      ),
    );

    // Highlight outer glowing ring on peak dot
    final peakOuterRing = Paint()
      ..color = (colors.primary500 as Color).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(peakPoint, 7.0, peakOuterRing);
    canvas.drawCircle(peakPoint, 4.0, dotPaint);
    canvas.drawCircle(peakPoint, 2.0, dotInner);

    // 8. Draw X-Axis Month Labels
    for (int i = 0; i < points.length; i++) {
      if (i < months.length) {
        final monthName = months[i];
        final monthTp = TextPainter(
          text: TextSpan(
            text: monthName,
            style: TextStyle(
              color: i == 3 ? (colors.primary800 as Color) : (colors.grey600 as Color),
              fontSize: 10,
              fontWeight: i == 3 ? FontWeight.bold : FontWeight.w500,
              fontFamily: 'Cairo',
            ),
          ),
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        )..layout();

        monthTp.paint(
          canvas,
          Offset(points[i].dx - monthTp.width / 2, chartBottom + 6),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _AreaChartPainter oldDelegate) {
    return oldDelegate.colors != colors ||
        oldDelegate.isArabic != isArabic ||
        oldDelegate.months != months;
  }
}

// -----------------------------------------------------------------------------
// MINI SPARKLINE PAINTER
// -----------------------------------------------------------------------------

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({
    required this.color,
    required this.data,
  });

  final Color color;
  final List<double> data;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final points = <Offset>[];
    final count = data.length;

    for (int i = 0; i < count; i++) {
      final x = (i / (count - 1)) * size.width;
      final y = size.height - (data[i] * size.height * 0.8) - 2;
      points.add(Offset(x, y));
    }

    final path = Path();
    path.moveTo(points.first.dx, points.first.dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final controlX = (p0.dx + p1.dx) / 2;
      path.cubicTo(controlX, p0.dy, controlX, p1.dy, p1.dx, p1.dy);
    }

    final strokePaint = Paint()
      ..color = color
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.data != data;
  }
}
