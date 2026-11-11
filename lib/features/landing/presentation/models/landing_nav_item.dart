import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';

/// Canonical landing page section descriptor shared between the scroll-spy,
/// desktop top navigation bar, mobile drawer, and footer links.
class LandingNavItem {
  const LandingNavItem({
    required this.sectionId,
    required this.label,
    required this.svgIconPath,
  });

  final String sectionId;
  final String label;
  final String svgIconPath;
}

class LandingNavCatalog {
  const LandingNavCatalog._();

  static const String heroId = 'hero';
  static const String pillarsId = 'pillars';
  static const String featuresId = 'features';
  static const String workflowId = 'workflow';
  static const String demoId = 'demo';
  static const String registrationId = 'registration';
  static const String contactId = 'contact';

  /// Ordered section items whose labels match the actual landing page sections.
  static List<LandingNavItem> items(AppLocalizations l10n) => [
        LandingNavItem(
          sectionId: heroId,
          label: l10n.navHome,
          svgIconPath: AppIcons.home,
        ),
        LandingNavItem(
          sectionId: pillarsId,
          label: l10n.navPillars,
          svgIconPath: AppIcons.leaf,
        ),
        LandingNavItem(
          sectionId: featuresId,
          label: l10n.navFeatures,
          svgIconPath: AppIcons.data,
        ),
        LandingNavItem(
          sectionId: workflowId,
          label: l10n.navWorkflow,
          svgIconPath: AppIcons.productionProcess,
        ),
        LandingNavItem(
          sectionId: demoId,
          label: l10n.navDemo,
          svgIconPath: AppIcons.chat,
        ),
        LandingNavItem(
          sectionId: registrationId,
          label: l10n.navRegisterSection,
          svgIconPath: AppIcons.organization,
        ),
      ];
}

