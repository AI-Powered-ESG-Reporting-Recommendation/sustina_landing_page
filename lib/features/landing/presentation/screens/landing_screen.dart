import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import '../widgets/landing_cta_section.dart';
import '../widgets/landing_features_section.dart';
import '../widgets/landing_footer.dart';
import '../widgets/landing_header.dart';
import '../widgets/landing_hero_section.dart';
import '../widgets/landing_nav_drawer.dart';
import '../widgets/landing_pillars_section.dart';
import '../widgets/landing_workflow_section.dart';

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
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String sectionKey) {
    GlobalKey? targetKey;
    switch (sectionKey) {
      case 'hero':
      case 'about':
        targetKey = _heroKey;
        break;
      case 'pillars':
        targetKey = _pillarsKey;
        break;
      case 'features':
        targetKey = _featuresKey;
        break;
      case 'workflow':
        targetKey = _workflowKey;
        break;
      case 'contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colors.background,
      endDrawer: LandingNavDrawer(
        onNavigateToSection: _scrollToSection,
      ),
      body: Column(
        children: [
          // Sticky Top Navigation Header
          LandingHeader(
            onNavigateToSection: _scrollToSection,
            onOpenDrawer: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),

          // Main Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  Container(
                    key: _heroKey,
                    child: LandingHeroSection(
                      onExplorePressed: () => _scrollToSection('pillars'),
                    ),
                  ),

                  // Pillars Section
                  Container(
                    key: _pillarsKey,
                    child: const LandingPillarsSection(),
                  ),

                  // Features Section
                  Container(
                    key: _featuresKey,
                    child: const LandingFeaturesSection(),
                  ),

                  // Workflow Section
                  Container(
                    key: _workflowKey,
                    child: const LandingWorkflowSection(),
                  ),

                  // Call To Action Section
                  const LandingCtaSection(),

                  // Footer
                  Container(
                    key: _contactKey,
                    child: LandingFooter(
                      onNavigateToSection: _scrollToSection,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
