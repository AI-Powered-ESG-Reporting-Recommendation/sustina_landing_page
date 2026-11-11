import 'dart:async';

import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/features/landing/presentation/models/landing_nav_item.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_cta_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_demo_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_features_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_footer.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_header.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_hero_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_nav_drawer.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_pillars_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_registration_overview_section.dart';
import 'package:suatina_web_project/features/landing/presentation/widgets/landing_workflow_section.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _pillarsKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _workflowKey = GlobalKey();
  final GlobalKey _demoKey = GlobalKey();
  final GlobalKey _registrationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  final ValueNotifier<String> _activeSectionNotifier = ValueNotifier<String>(
    LandingNavCatalog.heroId,
  );
  final ValueNotifier<bool> _isScrolledNotifier = ValueNotifier<bool>(false);

  bool _programmaticScrollActive = false;
  Timer? _programmaticScrollTimer;

  late final List<(String id, GlobalKey key)> _orderedSections = [
    (LandingNavCatalog.heroId, _heroKey),
    (LandingNavCatalog.pillarsId, _pillarsKey),
    (LandingNavCatalog.featuresId, _featuresKey),
    (LandingNavCatalog.workflowId, _workflowKey),
    (LandingNavCatalog.demoId, _demoKey),
    (LandingNavCatalog.registrationId, _registrationKey),
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _programmaticScrollTimer?.cancel();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _activeSectionNotifier.dispose();
    _isScrolledNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final nowScrolled = offset > 18;
    if (_isScrolledNotifier.value != nowScrolled) {
      _isScrolledNotifier.value = nowScrolled;
    }

    if (_programmaticScrollActive) return;

    final position = _scrollController.position;
    if (offset >= position.maxScrollExtent - 40 &&
        position.maxScrollExtent > 0) {
      if (_activeSectionNotifier.value != LandingNavCatalog.registrationId) {
        _activeSectionNotifier.value = LandingNavCatalog.registrationId;
      }
      return;
    }

    // Determine which section currently crosses the upper focal band below header
    const focalThreshold = 150.0;
    String detected = LandingNavCatalog.heroId;

    for (final section in _orderedSections) {
      final ctx = section.$2.currentContext;
      if (ctx == null) continue;
      final ro = ctx.findRenderObject();
      if (ro is! RenderBox || !ro.hasSize) continue;
      final topY = ro.localToGlobal(Offset.zero).dy;
      if (topY <= focalThreshold) {
        detected = section.$1;
      }
    }

    if (_activeSectionNotifier.value != detected) {
      _activeSectionNotifier.value = detected;
    }
  }

  Future<void> _scrollToSection(String sectionKey) async {
    GlobalKey? targetKey;
    switch (sectionKey) {
      case LandingNavCatalog.heroId:
      case 'about':
        targetKey = _heroKey;
        break;
      case LandingNavCatalog.pillarsId:
        targetKey = _pillarsKey;
        break;
      case LandingNavCatalog.featuresId:
        targetKey = _featuresKey;
        break;
      case LandingNavCatalog.workflowId:
        targetKey = _workflowKey;
        break;
      case LandingNavCatalog.demoId:
        targetKey = _demoKey;
        break;
      case LandingNavCatalog.registrationId:
        targetKey = _registrationKey;
        break;
      case LandingNavCatalog.contactId:
        targetKey = _contactKey;
        break;
    }

    final targetContext = targetKey?.currentContext;
    if (targetContext == null || !_scrollController.hasClients) return;

    final activeTargetId = sectionKey == 'about'
        ? LandingNavCatalog.heroId
        : (sectionKey == LandingNavCatalog.contactId
              ? LandingNavCatalog.registrationId
              : sectionKey);

    _activeSectionNotifier.value = activeTargetId;
    _programmaticScrollActive = true;
    _programmaticScrollTimer?.cancel();

    final renderBox = targetContext.findRenderObject();
    if (renderBox is RenderBox && renderBox.hasSize) {
      final targetGlobalY = renderBox.localToGlobal(Offset.zero).dy;
      // Offset slightly so section sits nicely beneath sticky top header (~86px)
      const stickyHeaderClearance = 88.0;
      final rawOffset =
          _scrollController.offset + targetGlobalY - stickyHeaderClearance;
      final clampedOffset = rawOffset.clamp(
        0.0,
        _scrollController.position.maxScrollExtent,
      );

      await _scrollController.animateTo(
        clampedOffset,
        duration: const Duration(milliseconds: 680),
        curve: Curves.easeInOutCubic,
      );
    } else {
      await Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }

    _programmaticScrollTimer = Timer(const Duration(milliseconds: 120), () {
      _programmaticScrollActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.background,
      endDrawer: ValueListenableBuilder<String>(
        valueListenable: _activeSectionNotifier,
        builder: (context, activeId, _) {
          return LandingNavDrawer(
            activeSectionId: activeId,
            onNavigateToSection: _scrollToSection,
          );
        },
      ),
      body: Stack(
        children: [
          // Main Scrollable Landing Content with top padding for floating header
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 82),

                // 1. Hero Section
                KeyedSubtree(
                  key: _heroKey,
                  child: LandingHeroSection(
                    onExplorePressed: () =>
                        _scrollToSection(LandingNavCatalog.pillarsId),
                    onBookDemoPressed: () =>
                        _scrollToSection(LandingNavCatalog.demoId),
                  ),
                ),

                // 2. ESG Pillars Section
                KeyedSubtree(
                  key: _pillarsKey,
                  child: const LandingPillarsSection(),
                ),

                // 3. Connected Floating Capabilities Ecosystem
                KeyedSubtree(
                  key: _featuresKey,
                  child: const LandingFeaturesSection(),
                ),

                // 4. Data Workflow Lifecycle Section
                KeyedSubtree(
                  key: _workflowKey,
                  child: const LandingWorkflowSection(),
                ),

                // 5. Interactive Demo Booking Section
                KeyedSubtree(
                  key: _demoKey,
                  child: const LandingDemoSection(),
                ),

                // 6. Company Registration 6-Stage Overview Section
                KeyedSubtree(
                  key: _registrationKey,
                  child: LandingRegistrationOverviewSection(
                    onBookDemoPressed: () =>
                        _scrollToSection(LandingNavCatalog.demoId),
                  ),
                ),

                // Call To Action Banner
                LandingCtaSection(
                  onBookDemoPressed: () =>
                      _scrollToSection(LandingNavCatalog.demoId),
                ),

                // Footer
                KeyedSubtree(
                  key: _contactKey,
                  child: LandingFooter(
                    onNavigateToSection: _scrollToSection,
                  ),
                ),
              ],
            ),
          ),

          // Floating Glassmorphic Sticky Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<bool>(
              valueListenable: _isScrolledNotifier,
              builder: (context, isScrolled, _) {
                return ValueListenableBuilder<String>(
                  valueListenable: _activeSectionNotifier,
                  builder: (context, activeId, _) {
                    return LandingHeader(
                      activeSectionId: activeId,
                      isScrolled: isScrolled,
                      onNavigateToSection: _scrollToSection,
                      onOpenDrawer: () =>
                          _scaffoldKey.currentState?.openEndDrawer(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
