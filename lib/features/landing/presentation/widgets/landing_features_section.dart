import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/utils/app_images.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingFeaturesSection extends StatefulWidget {
  const LandingFeaturesSection({super.key});

  @override
  State<LandingFeaturesSection> createState() => _LandingFeaturesSectionState();
}

class _LandingFeaturesSectionState extends State<LandingFeaturesSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ecosystemController;

  final GlobalKey _stackKey = GlobalKey();
  final GlobalKey _hubKey = GlobalKey();
  final List<GlobalKey> _cardPortKeys = List.generate(6, (_) => GlobalKey());

  final ValueNotifier<_EcosystemGeometry?> _geometryNotifier =
      ValueNotifier<_EcosystemGeometry?>(null);

  int? _hoveredIndex;
  int? _selectedIndex;
  bool _measurementScheduled = false;

  static const List<double> _cardPhases = [0.0, 1.15, 2.3, 0.65, 1.8, 2.95];
  static const List<bool> _featuredGlowCards = [
    false,
    true,
    false,
    true,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    _ecosystemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5600),
    )..repeat();
  }

  @override
  void dispose() {
    _ecosystemController.dispose();
    _geometryNotifier.dispose();
    super.dispose();
  }

  void _scheduleGeometryMeasurement() {
    if (_measurementScheduled) return;
    _measurementScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _measurementScheduled = false;
      if (!mounted) return;
      _measureGeometry();
    });
  }

  void _measureGeometry() {
    final stackBox =
        _stackKey.currentContext?.findRenderObject() as RenderBox?;
    final hubBox = _hubKey.currentContext?.findRenderObject() as RenderBox?;
    if (stackBox == null ||
        hubBox == null ||
        !stackBox.hasSize ||
        !hubBox.hasSize) {
      return;
    }

    final hubTopLeft = hubBox.localToGlobal(Offset.zero, ancestor: stackBox);
    final hubRect = hubTopLeft & hubBox.size;

    final ports = <Offset>[];
    for (final key in _cardPortKeys) {
      final portBox = key.currentContext?.findRenderObject() as RenderBox?;
      if (portBox == null || !portBox.hasSize) {
        return;
      }
      final portCenter = portBox.localToGlobal(
        portBox.size.center(Offset.zero),
        ancestor: stackBox,
      );
      ports.add(portCenter);
    }

    final next = _EcosystemGeometry(
      hubRect: hubRect,
      cardPorts: ports,
    );
    if (_geometryNotifier.value != next) {
      _geometryNotifier.value = next;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isRtl = context.isRtl;
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final deviceType = ResponsiveHelper.getDeviceType(context);
    final floatAmplitude = switch (deviceType) {
      DeviceScreenType.mobile => 2.5,
      DeviceScreenType.tablet => 4.0,
      DeviceScreenType.desktop => 5.0,
      DeviceScreenType.largeDesktop => 5.5,
    };

    final capabilities = [
      _EcosystemCapability(
        title: l10n.feature2Title,
        description: l10n.feature2Desc,
        tag: l10n.feature2Badge,
        svgIconPath: AppIcons.documentUploadIcon,
        accentColor: isDark ? colors.primary600 : colors.primary500,
        phase: _cardPhases[0],
        hasAmbientGlow: _featuredGlowCards[0],
      ),
      _EcosystemCapability(
        title: l10n.feature3Title,
        description: l10n.feature3Desc,
        tag: l10n.feature3Badge,
        svgIconPath: AppIcons.emissions,
        accentColor: colors.secondary500,
        phase: _cardPhases[1],
        hasAmbientGlow: _featuredGlowCards[1],
      ),
      _EcosystemCapability(
        title: l10n.feature4Title,
        description: l10n.feature4Desc,
        tag: l10n.feature4Badge,
        svgIconPath: AppIcons.organization,
        accentColor: colors.info700,
        phase: _cardPhases[2],
        hasAmbientGlow: _featuredGlowCards[2],
      ),
      _EcosystemCapability(
        title: l10n.feature1Title,
        description: l10n.feature1Desc,
        tag: l10n.feature1Badge,
        svgIconPath: AppIcons.chat,
        accentColor: isDark ? colors.primary700 : colors.primary600,
        phase: _cardPhases[3],
        hasAmbientGlow: _featuredGlowCards[3],
      ),
      _EcosystemCapability(
        title: l10n.feature5Title,
        description: l10n.feature5Desc,
        tag: l10n.feature5Badge,
        svgIconPath: AppIcons.productionProcess,
        accentColor: isDark ? colors.secondary600 : colors.secondary700,
        phase: _cardPhases[4],
        hasAmbientGlow: _featuredGlowCards[4],
      ),
      _EcosystemCapability(
        title: l10n.feature6Title,
        description: l10n.feature6Desc,
        tag: l10n.feature6Badge,
        svgIconPath: AppIcons.report,
        accentColor: isDark ? colors.primary600 : colors.primary500,
        phase: _cardPhases[5],
        hasAmbientGlow: _featuredGlowCards[5],
      ),
    ];

    final activeIndex = _hoveredIndex ?? _selectedIndex;
    final activeAccent =
        activeIndex != null ? capabilities[activeIndex].accentColor : null;

    _scheduleGeometryMeasurement();

    return Container(
      width: double.infinity,
      color: colors.grey50,
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
              category: l10n.featuresCategory,
              title: l10n.featuresTitle,
              subtitle: l10n.featuresSubtitle,
              badgeSvgPath: AppIcons.data,
            ),
            const SizedBox(height: 16),

            // Interactive Ecosystem Hint Pill
            AppRevealAnimation(
              delay: const Duration(milliseconds: 90),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colors.white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: colors.grey200),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.hub_rounded,
                      size: 15,
                      color: isDark ? colors.primary700 : colors.primary600,
                    ),
                    const SizedBox(width: 7),
                    Flexible(
                      child: Text(
                        l10n.ecosystemInteractiveHint,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.font12SemiBold.copyWith(
                          color: colors.neutral700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: context.responsiveValue(mobile: 32, desktop: 52)),

            // Connected Floating Ecosystem Canvas
            NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (_) {
                _scheduleGeometryMeasurement();
                return false;
              },
              child: SizeChangedLayoutNotifier(
                child: Stack(
                  key: _stackKey,
                  clipBehavior: Clip.none,
                  children: [
                    // Animated Connector Pathways & Traveling Pulses
                    Positioned.fill(
                      child: RepaintBoundary(
                        child: ValueListenableBuilder<_EcosystemGeometry?>(
                          valueListenable: _geometryNotifier,
                          builder: (context, geometry, _) {
                            return AnimatedBuilder(
                              animation: _ecosystemController,
                              builder: (context, _) {
                                return CustomPaint(
                                  painter: _EcosystemConnectorPainter(
                                    geometry: geometry,
                                    progress: disableAnimations
                                        ? 0.0
                                        : _ecosystemController.value,
                                    deviceType: deviceType,
                                    isRtl: isRtl,
                                    isDark: isDark,
                                    floatAmplitude: disableAnimations
                                        ? 0.0
                                        : floatAmplitude,
                                    cardPhases: _cardPhases,
                                    cardColors: capabilities
                                        .map((c) => c.accentColor)
                                        .toList(),
                                    activeIndex: activeIndex,
                                    idleTrackColor: colors.grey300,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    // Responsive Ecosystem Arrangement
                    switch (deviceType) {
                      DeviceScreenType.desktop ||
                      DeviceScreenType.largeDesktop =>
                        _buildDesktopEcosystem(
                          capabilities: capabilities,
                          floatAmplitude: floatAmplitude,
                          disableAnimations: disableAnimations,
                          activeIndex: activeIndex,
                          activeAccent: activeAccent,
                        ),
                      DeviceScreenType.tablet => _buildTabletEcosystem(
                        capabilities: capabilities,
                        floatAmplitude: floatAmplitude,
                        disableAnimations: disableAnimations,
                        activeIndex: activeIndex,
                        activeAccent: activeAccent,
                      ),
                      DeviceScreenType.mobile => _buildMobileEcosystem(
                        capabilities: capabilities,
                        floatAmplitude: floatAmplitude,
                        disableAnimations: disableAnimations,
                        activeIndex: activeIndex,
                        activeAccent: activeAccent,
                      ),
                    },
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopEcosystem({
    required List<_EcosystemCapability> capabilities,
    required double floatAmplitude,
    required bool disableAnimations,
    required int? activeIndex,
    required Color? activeAccent,
  }) {
    final hubGap = context.isLargeDesktop ? 76.0 : 54.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Start Wing: Cards 0, 1, 2 (ports on end edge facing Hub)
        Expanded(
          flex: 10,
          child: Column(
            children: [
              for (int i = 0; i < 3; i++) ...[
                _buildCard(
                  index: i,
                  capability: capabilities[i],
                  portAlignment: _PortSide.end,
                  floatAmplitude: floatAmplitude,
                  disableAnimations: disableAnimations,
                  activeIndex: activeIndex,
                ),
                if (i < 2) const SizedBox(height: 22),
              ],
            ],
          ),
        ),
        SizedBox(width: hubGap),

        // Central Sustina AI Core Hub
        Expanded(
          flex: 9,
          child: KeyedSubtree(
            key: _hubKey,
            child: _CentralAiHubCard(
              controller: _ecosystemController,
              disableAnimations: disableAnimations,
              highlightColor: activeAccent,
              isCompact: false,
            ),
          ),
        ),
        SizedBox(width: hubGap),

        // End Wing: Cards 3, 4, 5 (ports on start edge facing Hub)
        Expanded(
          flex: 10,
          child: Column(
            children: [
              for (int i = 3; i < 6; i++) ...[
                _buildCard(
                  index: i,
                  capability: capabilities[i],
                  portAlignment: _PortSide.start,
                  floatAmplitude: floatAmplitude,
                  disableAnimations: disableAnimations,
                  activeIndex: activeIndex,
                ),
                if (i < 5) const SizedBox(height: 22),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabletEcosystem({
    required List<_EcosystemCapability> capabilities,
    required double floatAmplitude,
    required bool disableAnimations,
    required int? activeIndex,
    required Color? activeAccent,
  }) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: KeyedSubtree(
            key: _hubKey,
            child: _CentralAiHubCard(
              controller: _ecosystemController,
              disableAnimations: disableAnimations,
              highlightColor: activeAccent,
              isCompact: false,
            ),
          ),
        ),
        const SizedBox(height: 44),
        for (int row = 0; row < 3; row++) ...[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _buildCard(
                    index: row * 2,
                    capability: capabilities[row * 2],
                    portAlignment: _PortSide.end,
                    floatAmplitude: floatAmplitude,
                    disableAnimations: disableAnimations,
                    activeIndex: activeIndex,
                  ),
                ),
                const SizedBox(width: 56),
                Expanded(
                  child: _buildCard(
                    index: row * 2 + 1,
                    capability: capabilities[row * 2 + 1],
                    portAlignment: _PortSide.start,
                    floatAmplitude: floatAmplitude,
                    disableAnimations: disableAnimations,
                    activeIndex: activeIndex,
                  ),
                ),
              ],
            ),
          ),
          if (row < 2) const SizedBox(height: 22),
        ],
      ],
    );
  }

  Widget _buildMobileEcosystem({
    required List<_EcosystemCapability> capabilities,
    required double floatAmplitude,
    required bool disableAnimations,
    required int? activeIndex,
    required Color? activeAccent,
  }) {
    return Column(
      children: [
        KeyedSubtree(
          key: _hubKey,
          child: _CentralAiHubCard(
            controller: _ecosystemController,
            disableAnimations: disableAnimations,
            highlightColor: activeAccent,
            isCompact: true,
          ),
        ),
        const SizedBox(height: 28),
        for (int i = 0; i < capabilities.length; i++) ...[
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 30),
            child: _buildCard(
              index: i,
              capability: capabilities[i],
              portAlignment: _PortSide.start,
              floatAmplitude: floatAmplitude,
              disableAnimations: disableAnimations,
              activeIndex: activeIndex,
            ),
          ),
          if (i < capabilities.length - 1) const SizedBox(height: 16),
        ],
      ],
    );
  }

  Widget _buildCard({
    required int index,
    required _EcosystemCapability capability,
    required _PortSide portAlignment,
    required double floatAmplitude,
    required bool disableAnimations,
    required int? activeIndex,
  }) {
    return AppRevealAnimation(
      delay: Duration(milliseconds: 70 * index),
      onRevealed: _scheduleGeometryMeasurement,
      child: _FloatingEcosystemCard(
        capability: capability,
        portKey: _cardPortKeys[index],
        portSide: portAlignment,
        controller: _ecosystemController,
        floatAmplitude: floatAmplitude,
        disableAnimations: disableAnimations,
        isHighlighted: activeIndex == index,
        isDimmed: activeIndex != null && activeIndex != index,
        onHoverChanged: (hovering) {
          setState(() {
            _hoveredIndex = hovering ? index : (_hoveredIndex == index ? null : _hoveredIndex);
          });
        },
        onTap: () {
          setState(() {
            _selectedIndex = _selectedIndex == index ? null : index;
          });
        },
      ),
    );
  }
}

enum _PortSide { start, end }

class _EcosystemCapability {
  const _EcosystemCapability({
    required this.title,
    required this.description,
    required this.tag,
    required this.svgIconPath,
    required this.accentColor,
    required this.phase,
    required this.hasAmbientGlow,
  });

  final String title;
  final String description;
  final String tag;
  final String svgIconPath;
  final Color accentColor;
  final double phase;
  final bool hasAmbientGlow;
}

class _CentralAiHubCard extends StatelessWidget {
  const _CentralAiHubCard({
    required this.controller,
    required this.disableAnimations,
    required this.highlightColor,
    required this.isCompact,
  });

  final AnimationController controller;
  final bool disableAnimations;
  final Color? highlightColor;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;

    // Rich deep emerald core in both modes so connected white/gold hub graphics pop
    final bgGradient = isDark
        ? [colors.primary200, colors.primary100]
        : [colors.primary600, colors.primary800, colors.primary900];
    final onHubPrimary = isDark ? colors.neutral900 : colors.grey0;
    final onHubMuted = onHubPrimary.withValues(alpha: 0.78);
    final glowColor = highlightColor ?? colors.primary500;

    final miniNodes = [
      (AppIcons.energy, l10n.ecosystemNodeEnergy),
      (AppIcons.dataItem, l10n.ecosystemNodeWater),
      (AppIcons.materials, l10n.ecosystemNodeSuppliers),
      (AppIcons.carbonPricing, l10n.ecosystemNodePolicies),
    ];

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final pulse = disableAnimations
              ? 0.5
              : 0.5 + 0.5 * math.sin(controller.value * 2 * math.pi);
          return Container(
            padding: EdgeInsets.all(isCompact ? 20 : 26),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: bgGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(
                color: (highlightColor ?? colors.secondary500).withValues(
                  alpha: 0.35 + 0.25 * pulse,
                ),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: glowColor.withValues(
                    alpha: (isDark ? 0.28 : 0.24) + 0.10 * pulse,
                  ),
                  blurRadius: 34 + 10 * pulse,
                  spreadRadius: -2,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: child,
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pulsing AI Core Emblem
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, _) {
                    final wave = disableAnimations
                        ? 0.0
                        : (controller.value * 1.5) % 1.0;
                    return Container(
                      width: 68 + 18 * wave,
                      height: 68 + 18 * wave,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colors.secondary400.withValues(
                            alpha: (1.0 - wave) * 0.48,
                          ),
                          width: 1.5,
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(13),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: onHubPrimary.withValues(alpha: 0.12),
                    border: Border.all(
                      color: colors.secondary400.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Image.asset(
                    AppImages.logoSplash,
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => Icon(
                      Icons.auto_awesome_rounded,
                      color: colors.secondary400,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Hub Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: colors.secondary500.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: colors.secondary400.withValues(alpha: 0.45),
                ),
              ),
              child: Text(
                l10n.ecosystemHubBadge,
                style: AppTextStyles.font11SemiBold.copyWith(
                  color: colors.secondary300,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Text(
              l10n.ecosystemHubTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.font20Bold.copyWith(
                fontSize: isCompact ? 18 : 20,
                color: onHubPrimary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.ecosystemHubSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.font12Regular.copyWith(
                fontSize: 12.5,
                color: onHubMuted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 18),

            // 4 Live Connected Stream Mini-Nodes (inspired by onboard_2.png)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                for (final node in miniNodes)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: onHubPrimary.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: onHubPrimary.withValues(alpha: 0.16),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SustinaSvgIcon(
                          assetPath: node.$1,
                          size: 14,
                          color: colors.secondary400,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          node.$2,
                          style: AppTextStyles.font12Bold.copyWith(
                            color: onHubPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: colors.secondary400,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingEcosystemCard extends StatefulWidget {
  const _FloatingEcosystemCard({
    required this.capability,
    required this.portKey,
    required this.portSide,
    required this.controller,
    required this.floatAmplitude,
    required this.disableAnimations,
    required this.isHighlighted,
    required this.isDimmed,
    required this.onHoverChanged,
    required this.onTap,
  });

  final _EcosystemCapability capability;
  final GlobalKey portKey;
  final _PortSide portSide;
  final AnimationController controller;
  final double floatAmplitude;
  final bool disableAnimations;
  final bool isHighlighted;
  final bool isDimmed;
  final ValueChanged<bool> onHoverChanged;
  final VoidCallback onTap;

  @override
  State<_FloatingEcosystemCard> createState() => _FloatingEcosystemCardState();
}

class _FloatingEcosystemCardState extends State<_FloatingEcosystemCard> {
  bool _localHover = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final cap = widget.capability;
    final active = widget.isHighlighted || _localHover;

    final portDot = Container(
      key: widget.portKey,
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? cap.accentColor : colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: cap.accentColor,
          width: 2.2,
        ),
        boxShadow: [
          if (active || cap.hasAmbientGlow)
            BoxShadow(
              color: cap.accentColor.withValues(alpha: 0.45),
              blurRadius: 8,
              spreadRadius: 1,
            ),
        ],
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          final dy = widget.disableAnimations
              ? 0.0
              : widget.floatAmplitude *
                  math.sin(
                    widget.controller.value * 2 * math.pi + cap.phase,
                  );
          final glowBreath = widget.disableAnimations
              ? 0.5
              : 0.5 +
                  0.5 *
                      math.sin(
                        widget.controller.value * 2 * math.pi + cap.phase,
                      );

          return Transform.translate(
            offset: Offset(0, dy + (active ? -4.0 : 0.0)),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 220),
              opacity: widget.isDimmed ? 0.62 : 1.0,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) {
                  setState(() => _localHover = true);
                  widget.onHoverChanged(true);
                },
                onExit: (_) {
                  setState(() => _localHover = false);
                  widget.onHoverChanged(false);
                },
                child: GestureDetector(
                  onTap: widget.onTap,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: AlignmentDirectional.centerStart,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 240),
                        curve: Curves.easeOutCubic,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: active
                                ? cap.accentColor
                                : (cap.hasAmbientGlow
                                      ? cap.accentColor.withValues(
                                          alpha: 0.30 + 0.16 * glowBreath,
                                        )
                                      : colors.grey200),
                            width: active ? 1.7 : 1.2,
                          ),
                          boxShadow: [
                            if (active || cap.hasAmbientGlow)
                              BoxShadow(
                                color: cap.accentColor.withValues(
                                  alpha: active
                                      ? (isDark ? 0.26 : 0.18)
                                      : (isDark ? 0.12 : 0.08) *
                                            (0.6 + 0.4 * glowBreath),
                                ),
                                blurRadius: active ? 28 : 20,
                                spreadRadius: active ? 1 : 0,
                                offset: Offset(0, active ? 10 : 6),
                              )
                            else
                              BoxShadow(
                                color: colors.black.withValues(
                                  alpha: isDark ? 0.24 : 0.04,
                                ),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                          ],
                        ),
                        child: child,
                      ),

                      // Anchored Edge Port Dot (Start or End facing Hub)
                      if (widget.portSide == _PortSide.start)
                        PositionedDirectional(start: -6, child: portDot)
                      else
                        PositionedDirectional(end: -6, child: portDot),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: cap.accentColor.withValues(
                      alpha: isDark ? 0.16 : 0.10,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: cap.accentColor.withValues(alpha: 0.25),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SustinaSvgIcon(
                    assetPath: cap.svgIconPath,
                    size: 22,
                    color: cap.accentColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: cap.accentColor.withValues(
                      alpha: isDark ? 0.14 : 0.09,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    cap.tag,
                    style: AppTextStyles.font11SemiBold.copyWith(
                      fontWeight: FontWeight.w700,
                      color: cap.accentColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              cap.title,
              style: AppTextStyles.font16Bold.copyWith(
                fontSize: 16.5,
                color: colors.neutral900,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              cap.description,
              style: AppTextStyles.font13Regular.copyWith(
                color: colors.neutral700,
                height: 1.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EcosystemGeometry {
  const _EcosystemGeometry({
    required this.hubRect,
    required this.cardPorts,
  });

  final Rect hubRect;
  final List<Offset> cardPorts;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! _EcosystemGeometry) return false;
    if (!_rectClose(hubRect, other.hubRect)) return false;
    if (cardPorts.length != other.cardPorts.length) return false;
    for (int i = 0; i < cardPorts.length; i++) {
      if ((cardPorts[i] - other.cardPorts[i]).distance > 0.6) return false;
    }
    return true;
  }

  @override
  int get hashCode => Object.hash(hubRect, Object.hashAll(cardPorts));

  static bool _rectClose(Rect a, Rect b) {
    return (a.left - b.left).abs() < 0.6 &&
        (a.top - b.top).abs() < 0.6 &&
        (a.right - b.right).abs() < 0.6 &&
        (a.bottom - b.bottom).abs() < 0.6;
  }
}

/// Draws responsive orthogonal/curved conduits & traveling light pulses
/// synchronized with the floating motion of every card.
class _EcosystemConnectorPainter extends CustomPainter {
  _EcosystemConnectorPainter({
    required this.geometry,
    required this.progress,
    required this.deviceType,
    required this.isRtl,
    required this.isDark,
    required this.floatAmplitude,
    required this.cardPhases,
    required this.cardColors,
    required this.activeIndex,
    required this.idleTrackColor,
  });

  final _EcosystemGeometry? geometry;
  final double progress;
  final DeviceScreenType deviceType;
  final bool isRtl;
  final bool isDark;
  final double floatAmplitude;
  final List<double> cardPhases;
  final List<Color> cardColors;
  final int? activeIndex;
  final Color idleTrackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final geo = geometry;
    if (geo == null || geo.cardPorts.length < 6) return;

    final hub = geo.hubRect;
    final isDesktopLayout = deviceType.isDesktopOrLarger;
    final isTabletLayout = deviceType == DeviceScreenType.tablet;

    for (int i = 0; i < geo.cardPorts.length; i++) {
      final dy = floatAmplitude *
          math.sin(progress * 2 * math.pi + cardPhases[i]);
      final cardEnd = geo.cardPorts[i].translate(0, dy);
      final accent = cardColors[i];
      final isHighlighted = activeIndex == i;
      final isDimmed = activeIndex != null && activeIndex != i;

      late final Path path;
      if (isDesktopLayout) {
        final isStartWing = i < 3;
        final attachLeft = isRtl ? !isStartWing : isStartWing;
        final wingRow = i % 3;
        final hubY = hub.top + hub.height * (0.28 + wingRow * 0.22);
        final hubStart = Offset(attachLeft ? hub.left : hub.right, hubY);
        path = _buildDesktopPath(hubStart, cardEnd);
      } else if (isTabletLayout) {
        final trunkX = hub.center.dx;
        final trunkStart = Offset(trunkX, hub.bottom);
        path = _buildTabletPath(trunkStart, cardEnd);
      } else {
        final spineX = isRtl ? size.width - 13 : 13.0;
        final hubStart = Offset(hub.center.dx, hub.bottom);
        path = _buildMobilePath(hubStart, cardEnd, spineX);
      }

      // 1. Base Conduit Track
      final basePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = isHighlighted ? 2.4 : 1.5
        ..color = isHighlighted
            ? accent.withValues(alpha: isDark ? 0.72 : 0.65)
            : idleTrackColor.withValues(
                alpha: isDimmed ? 0.32 : (isDark ? 0.72 : 0.85),
              );

      if (!isHighlighted) {
        _drawDashedPath(canvas, path, basePaint, dash: 7, gap: 5);
      } else {
        // Subtle outer bloom + bright solid line when highlighted
        final bloomPaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 6.5
          ..color = accent.withValues(alpha: isDark ? 0.22 : 0.16);
        canvas.drawPath(path, bloomPaint);
        canvas.drawPath(path, basePaint);
      }

      // 2. Traveling Light Pulse along the PathMetric
      if (!isDimmed) {
        final metrics = path.computeMetrics().toList();
        if (metrics.isNotEmpty) {
          final metric = metrics.first;
          final totalLen = metric.length;
          if (totalLen > 12) {
            final pulseHead = ((progress + i * 0.16) % 1.0) * totalLen;
            final tailLen = math.min(totalLen * 0.26, 48.0);
            final pulseStart = math.max(0.0, pulseHead - tailLen);
            final pulseSegment = metric.extractPath(pulseStart, pulseHead);

            final pulsePaint = Paint()
              ..style = PaintingStyle.stroke
              ..strokeCap = StrokeCap.round
              ..strokeWidth = isHighlighted ? 3.2 : 2.2
              ..shader = ui.Gradient.linear(
                metric.getTangentForOffset(pulseStart)?.position ?? cardEnd,
                metric.getTangentForOffset(pulseHead)?.position ?? cardEnd,
                [
                  accent.withValues(alpha: 0.0),
                  accent.withValues(alpha: isHighlighted ? 0.95 : 0.75),
                ],
              );
            canvas.drawPath(pulseSegment, pulsePaint);

            final tangent = metric.getTangentForOffset(pulseHead);
            if (tangent != null) {
              final orbGlow = Paint()
                ..color = accent.withValues(alpha: isHighlighted ? 0.36 : 0.24);
              final orbCore = Paint()..color = accent;
              canvas.drawCircle(
                tangent.position,
                isHighlighted ? 7.0 : 5.0,
                orbGlow,
              );
              canvas.drawCircle(
                tangent.position,
                isHighlighted ? 3.2 : 2.4,
                orbCore,
              );
            }
          }
        }
      }
    }
  }

  Path _buildDesktopPath(Offset hubStart, Offset cardEnd) {
    final midX = (hubStart.dx + cardEnd.dx) / 2;
    return Path()
      ..moveTo(hubStart.dx, hubStart.dy)
      ..cubicTo(
        midX,
        hubStart.dy,
        midX,
        cardEnd.dy,
        cardEnd.dx,
        cardEnd.dy,
      );
  }

  Path _buildTabletPath(Offset trunkStart, Offset cardEnd) {
    final spineX = trunkStart.dx;
    final goingLeft = cardEnd.dx < spineX;
    final r = 14.0;
    final cornerY = cardEnd.dy;
    final path = Path()..moveTo(spineX, trunkStart.dy);

    if ((cornerY - trunkStart.dy).abs() > r) {
      path.lineTo(spineX, cornerY - r);
      path.quadraticBezierTo(
        spineX,
        cornerY,
        goingLeft ? spineX - r : spineX + r,
        cornerY,
      );
    } else {
      path.lineTo(spineX, cornerY);
    }
    path.lineTo(cardEnd.dx, cardEnd.dy);
    return path;
  }

  Path _buildMobilePath(Offset hubStart, Offset cardEnd, double spineX) {
    final goingRight = cardEnd.dx > spineX;
    final r = 10.0;
    final dropY = hubStart.dy + 14.0;
    final movingRightFromHub = spineX > hubStart.dx;
    final path = Path()..moveTo(hubStart.dx, hubStart.dy);

    // Emerge smoothly from bottom center of Hub into the vertical side spine
    path.lineTo(hubStart.dx, dropY - r);
    path.quadraticBezierTo(
      hubStart.dx,
      dropY,
      movingRightFromHub ? hubStart.dx + r : hubStart.dx - r,
      dropY,
    );
    path.lineTo(
      movingRightFromHub ? spineX - r : spineX + r,
      dropY,
    );
    path.quadraticBezierTo(spineX, dropY, spineX, dropY + r);

    if ((cardEnd.dy - dropY).abs() > r * 2) {
      path.lineTo(spineX, cardEnd.dy - r);
      path.quadraticBezierTo(
        spineX,
        cardEnd.dy,
        goingRight ? spineX + r : spineX - r,
        cardEnd.dy,
      );
    }
    path.lineTo(cardEnd.dx, cardEnd.dy);
    return path;
  }

  void _drawDashedPath(
    Canvas canvas,
    Path source,
    Paint paint, {
    required double dash,
    required double gap,
  }) {
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = math.min(distance + dash, metric.length);
        canvas.drawPath(metric.extractPath(distance, next), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _EcosystemConnectorPainter oldDelegate) {
    return oldDelegate.geometry != geometry ||
        oldDelegate.progress != progress ||
        oldDelegate.deviceType != deviceType ||
        oldDelegate.isRtl != isRtl ||
        oldDelegate.isDark != isDark ||
        oldDelegate.activeIndex != activeIndex ||
        oldDelegate.idleTrackColor != idleTrackColor;
  }
}
