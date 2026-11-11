import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application window title
  ///
  /// In en, this message translates to:
  /// **'Sustina | AI-Powered ESG Platform'**
  String get appTitle;

  /// No description provided for @brandName.
  ///
  /// In en, this message translates to:
  /// **'SUSTINA'**
  String get brandName;

  /// No description provided for @brandLogoSemantics.
  ///
  /// In en, this message translates to:
  /// **'Sustina official platform logo'**
  String get brandLogoSemantics;

  /// No description provided for @navAbout.
  ///
  /// In en, this message translates to:
  /// **'About Platform'**
  String get navAbout;

  /// No description provided for @navPillars.
  ///
  /// In en, this message translates to:
  /// **'ESG Pillars'**
  String get navPillars;

  /// No description provided for @navFeatures.
  ///
  /// In en, this message translates to:
  /// **'Capabilities'**
  String get navFeatures;

  /// No description provided for @navWorkflow.
  ///
  /// In en, this message translates to:
  /// **'Workflow'**
  String get navWorkflow;

  /// No description provided for @navDemo.
  ///
  /// In en, this message translates to:
  /// **'Book a Demo'**
  String get navDemo;

  /// No description provided for @navRegisterSection.
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get navRegisterSection;

  /// No description provided for @navLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get navLogin;

  /// No description provided for @navRegister.
  ///
  /// In en, this message translates to:
  /// **'Register Company'**
  String get navRegister;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get navContact;

  /// No description provided for @navCloseDrawer.
  ///
  /// In en, this message translates to:
  /// **'Close menu'**
  String get navCloseDrawer;

  /// No description provided for @navOpenDrawer.
  ///
  /// In en, this message translates to:
  /// **'Open navigation menu'**
  String get navOpenDrawer;

  /// No description provided for @mainMenu.
  ///
  /// In en, this message translates to:
  /// **'Main Menu'**
  String get mainMenu;

  /// No description provided for @loginShort.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get loginShort;

  /// No description provided for @themeModeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Toggle Theme Mode'**
  String get themeModeTooltip;

  /// No description provided for @langSwitchTooltip.
  ///
  /// In en, this message translates to:
  /// **'تغيير إلى العربية'**
  String get langSwitchTooltip;

  /// No description provided for @langNameAr.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get langNameAr;

  /// No description provided for @langNameEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langNameEn;

  /// No description provided for @heroBadge.
  ///
  /// In en, this message translates to:
  /// **'Sustina — AI-Powered ESG Reporting & Recommendation Platform'**
  String get heroBadge;

  /// No description provided for @heroHeadlineStart.
  ///
  /// In en, this message translates to:
  /// **'Automate Sustainability, Calculate Emissions, and Deliver '**
  String get heroHeadlineStart;

  /// No description provided for @heroHeadlineHighlight.
  ///
  /// In en, this message translates to:
  /// **'Global-Standard ESG Reports'**
  String get heroHeadlineHighlight;

  /// No description provided for @heroHeadlineEnd.
  ///
  /// In en, this message translates to:
  /// **' Powered by AI'**
  String get heroHeadlineEnd;

  /// No description provided for @heroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Together towards a more sustainable future — Automate greenhouse gas accounting (Scope 1, 2, 3), streamline operational ESG metrics with AI, and generate audit-ready compliance reports.'**
  String get heroSubtitle;

  /// No description provided for @heroCtaStart.
  ///
  /// In en, this message translates to:
  /// **'Register Your Company'**
  String get heroCtaStart;

  /// No description provided for @heroCtaExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore Pillars & Capabilities'**
  String get heroCtaExplore;

  /// No description provided for @heroTrustPill1.
  ///
  /// In en, this message translates to:
  /// **'Scope 1, 2, 3 GHG Accounting'**
  String get heroTrustPill1;

  /// No description provided for @heroTrustPill2.
  ///
  /// In en, this message translates to:
  /// **'AI Bill Extraction (OCR)'**
  String get heroTrustPill2;

  /// No description provided for @heroTrustPill3.
  ///
  /// In en, this message translates to:
  /// **'Interactive AI ESG Assistant'**
  String get heroTrustPill3;

  /// No description provided for @heroTrustPill4.
  ///
  /// In en, this message translates to:
  /// **'CBAM & Audit-Ready Export'**
  String get heroTrustPill4;

  /// No description provided for @heroScrollTooltip.
  ///
  /// In en, this message translates to:
  /// **'Scroll to explore'**
  String get heroScrollTooltip;

  /// No description provided for @heroChipScope.
  ///
  /// In en, this message translates to:
  /// **'Scope 1, 2, 3'**
  String get heroChipScope;

  /// No description provided for @heroChipOcr.
  ///
  /// In en, this message translates to:
  /// **'AI OCR Engine'**
  String get heroChipOcr;

  /// No description provided for @heroChipEsg.
  ///
  /// In en, this message translates to:
  /// **'ESG Score 92%'**
  String get heroChipEsg;

  /// No description provided for @previewKpiEsgScore.
  ///
  /// In en, this message translates to:
  /// **'Overall ESG Score'**
  String get previewKpiEsgScore;

  /// No description provided for @previewKpiScope1.
  ///
  /// In en, this message translates to:
  /// **'Scope 1 Direct Emissions'**
  String get previewKpiScope1;

  /// No description provided for @previewKpiEnergy.
  ///
  /// In en, this message translates to:
  /// **'Clean Energy Consumption'**
  String get previewKpiEnergy;

  /// No description provided for @previewKpiDiversity.
  ///
  /// In en, this message translates to:
  /// **'Workforce Diversity & Parity'**
  String get previewKpiDiversity;

  /// No description provided for @previewChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Emissions vs Target Reductions'**
  String get previewChartTitle;

  /// No description provided for @previewAiRecBadge.
  ///
  /// In en, this message translates to:
  /// **'Smart Recommendation'**
  String get previewAiRecBadge;

  /// No description provided for @previewAiRecText.
  ///
  /// In en, this message translates to:
  /// **'Optimizing HVAC schedules and solar transition can reduce Scope 2 energy emissions by 14% this quarter.'**
  String get previewAiRecText;

  /// No description provided for @previewFactoryName.
  ///
  /// In en, this message translates to:
  /// **'Advanced Petrochemicals Complex'**
  String get previewFactoryName;

  /// No description provided for @previewUrl.
  ///
  /// In en, this message translates to:
  /// **'app.sustina.io/dashboard'**
  String get previewUrl;

  /// No description provided for @previewEsgReady.
  ///
  /// In en, this message translates to:
  /// **'ESG Compliance Ready'**
  String get previewEsgReady;

  /// No description provided for @previewCertifiedData.
  ///
  /// In en, this message translates to:
  /// **'Audit Verified Data'**
  String get previewCertifiedData;

  /// No description provided for @previewEsgScore.
  ///
  /// In en, this message translates to:
  /// **'Overall ESG Score'**
  String get previewEsgScore;

  /// No description provided for @previewExcellent.
  ///
  /// In en, this message translates to:
  /// **'Tier 1 — High Compliance'**
  String get previewExcellent;

  /// No description provided for @previewCompletionRate.
  ///
  /// In en, this message translates to:
  /// **'Quarterly Data Completed'**
  String get previewCompletionRate;

  /// No description provided for @previewMetricsCount.
  ///
  /// In en, this message translates to:
  /// **'68/74 Metrics'**
  String get previewMetricsCount;

  /// No description provided for @previewCarbonFootprint.
  ///
  /// In en, this message translates to:
  /// **'Net Carbon Emissions'**
  String get previewCarbonFootprint;

  /// No description provided for @previewMetricsDistribution.
  ///
  /// In en, this message translates to:
  /// **'ESG Pillar Progress Rate'**
  String get previewMetricsDistribution;

  /// No description provided for @previewEnvLabel.
  ///
  /// In en, this message translates to:
  /// **'Environmental (Scope 1, 2, 3)'**
  String get previewEnvLabel;

  /// No description provided for @previewSocLabel.
  ///
  /// In en, this message translates to:
  /// **'Social & HSE Safety'**
  String get previewSocLabel;

  /// No description provided for @previewGovLabel.
  ///
  /// In en, this message translates to:
  /// **'Governance & Compliance'**
  String get previewGovLabel;

  /// No description provided for @previewAiInsightTitle.
  ///
  /// In en, this message translates to:
  /// **'Sustina AI Insight'**
  String get previewAiInsightTitle;

  /// No description provided for @previewAiInsightContent.
  ///
  /// In en, this message translates to:
  /// **'Optimizing chiller load scheduling during peak hours will reduce Scope 2 grid emissions by 14%.'**
  String get previewAiInsightContent;

  /// No description provided for @pillarsCategory.
  ///
  /// In en, this message translates to:
  /// **'ESG Pillars'**
  String get pillarsCategory;

  /// No description provided for @pillarsTitle.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive Coverage for Environmental, Social & Governance Pillars'**
  String get pillarsTitle;

  /// No description provided for @pillarsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A balanced framework ensuring organizations monitor operational impact, empower workforce wellbeing, and maintain transparency in corporate governance.'**
  String get pillarsSubtitle;

  /// No description provided for @pillarETitle.
  ///
  /// In en, this message translates to:
  /// **'Environmental'**
  String get pillarETitle;

  /// No description provided for @pillarESubtitle.
  ///
  /// In en, this message translates to:
  /// **'Environmental Dimension'**
  String get pillarESubtitle;

  /// No description provided for @pillarEDesc.
  ///
  /// In en, this message translates to:
  /// **'Full tracking of carbon footprint, natural resource consumption, and sustainable waste reduction.'**
  String get pillarEDesc;

  /// No description provided for @pillarEMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Tracked Indicators:'**
  String get pillarEMetricsTitle;

  /// No description provided for @pillarEMetric1.
  ///
  /// In en, this message translates to:
  /// **'Direct combustion & vehicle fleet fuel (Scope 1)'**
  String get pillarEMetric1;

  /// No description provided for @pillarEMetric2.
  ///
  /// In en, this message translates to:
  /// **'Electricity & district cooling grids (Scope 2)'**
  String get pillarEMetric2;

  /// No description provided for @pillarEMetric3.
  ///
  /// In en, this message translates to:
  /// **'Supply chain & business travel logistics (Scope 3)'**
  String get pillarEMetric3;

  /// No description provided for @pillarEMetric4.
  ///
  /// In en, this message translates to:
  /// **'Municipal, well & recycled water usage'**
  String get pillarEMetric4;

  /// No description provided for @pillarEMetric5.
  ///
  /// In en, this message translates to:
  /// **'Hazardous, electronic & recycled waste management'**
  String get pillarEMetric5;

  /// No description provided for @pillarSTitle.
  ///
  /// In en, this message translates to:
  /// **'Social'**
  String get pillarSTitle;

  /// No description provided for @pillarSSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Social Dimension'**
  String get pillarSSubtitle;

  /// No description provided for @pillarSDesc.
  ///
  /// In en, this message translates to:
  /// **'Promoting human capital safety, fair workplace practices, and community sustainability engagement.'**
  String get pillarSDesc;

  /// No description provided for @pillarSMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Tracked Indicators:'**
  String get pillarSMetricsTitle;

  /// No description provided for @pillarSMetric1.
  ///
  /// In en, this message translates to:
  /// **'Occupational health, lost time injuries & safety audits'**
  String get pillarSMetric1;

  /// No description provided for @pillarSMetric2.
  ///
  /// In en, this message translates to:
  /// **'Training hours, skill development & human rights'**
  String get pillarSMetric2;

  /// No description provided for @pillarSMetric3.
  ///
  /// In en, this message translates to:
  /// **'Diversity, inclusion & gender pay parity'**
  String get pillarSMetric3;

  /// No description provided for @pillarSMetric4.
  ///
  /// In en, this message translates to:
  /// **'Employee & contractor turnover rates'**
  String get pillarSMetric4;

  /// No description provided for @pillarSMetric5.
  ///
  /// In en, this message translates to:
  /// **'Customer satisfaction & community social responsibility'**
  String get pillarSMetric5;

  /// No description provided for @pillarGTitle.
  ///
  /// In en, this message translates to:
  /// **'Governance'**
  String get pillarGTitle;

  /// No description provided for @pillarGSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Governance Dimension'**
  String get pillarGSubtitle;

  /// No description provided for @pillarGDesc.
  ///
  /// In en, this message translates to:
  /// **'Instilling transparency, integrity, risk management, and regulatory compliance.'**
  String get pillarGDesc;

  /// No description provided for @pillarGMetricsTitle.
  ///
  /// In en, this message translates to:
  /// **'Key Tracked Indicators:'**
  String get pillarGMetricsTitle;

  /// No description provided for @pillarGMetric1.
  ///
  /// In en, this message translates to:
  /// **'Anti-bribery & corruption policies and employee training'**
  String get pillarGMetric1;

  /// No description provided for @pillarGMetric2.
  ///
  /// In en, this message translates to:
  /// **'Operating licenses validity & legal facility compliance'**
  String get pillarGMetric2;

  /// No description provided for @pillarGMetric3.
  ///
  /// In en, this message translates to:
  /// **'Cybersecurity, confidentiality & data privacy'**
  String get pillarGMetric3;

  /// No description provided for @pillarGMetric4.
  ///
  /// In en, this message translates to:
  /// **'Supplier adherence to Corporate Code of Conduct'**
  String get pillarGMetric4;

  /// No description provided for @pillarGMetric5.
  ///
  /// In en, this message translates to:
  /// **'Grievance resolution mechanism within SLA (45 days)'**
  String get pillarGMetric5;

  /// No description provided for @featuresCategory.
  ///
  /// In en, this message translates to:
  /// **'Smart Capabilities'**
  String get featuresCategory;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Connected Sustainability Intelligence Ecosystem'**
  String get featuresTitle;

  /// No description provided for @featuresSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Six intelligent capabilities orchestrated around one central AI engine — uniting data ingestion, carbon math, department workflows, and compliance reporting.'**
  String get featuresSubtitle;

  /// No description provided for @ecosystemHubBadge.
  ///
  /// In en, this message translates to:
  /// **'SUSTINA AI CORE'**
  String get ecosystemHubBadge;

  /// No description provided for @ecosystemHubTitle.
  ///
  /// In en, this message translates to:
  /// **'Central Intelligence Hub'**
  String get ecosystemHubTitle;

  /// No description provided for @ecosystemHubSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Real-time orchestration connecting operational streams into verified ESG outcomes'**
  String get ecosystemHubSubtitle;

  /// No description provided for @ecosystemNodeEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy'**
  String get ecosystemNodeEnergy;

  /// No description provided for @ecosystemNodeWater.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get ecosystemNodeWater;

  /// No description provided for @ecosystemNodeSuppliers.
  ///
  /// In en, this message translates to:
  /// **'Suppliers'**
  String get ecosystemNodeSuppliers;

  /// No description provided for @ecosystemNodePolicies.
  ///
  /// In en, this message translates to:
  /// **'Policies'**
  String get ecosystemNodePolicies;

  /// No description provided for @ecosystemConnectedStatus.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get ecosystemConnectedStatus;

  /// No description provided for @ecosystemInteractiveHint.
  ///
  /// In en, this message translates to:
  /// **'Hover or select any capability card to trace its live connection stream'**
  String get ecosystemInteractiveHint;

  /// No description provided for @feature1Title.
  ///
  /// In en, this message translates to:
  /// **'Interactive AI Assistant (AI Chat)'**
  String get feature1Title;

  /// No description provided for @feature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Virtual assistant powered by LLMs and Retrieval-Augmented Generation (RAG), delivering tailored recommendations to lower emissions based on facility data.'**
  String get feature1Desc;

  /// No description provided for @feature1Badge.
  ///
  /// In en, this message translates to:
  /// **'LLM & RAG'**
  String get feature1Badge;

  /// No description provided for @feature2Title.
  ///
  /// In en, this message translates to:
  /// **'Automated Document Extraction (OCR)'**
  String get feature2Title;

  /// No description provided for @feature2Desc.
  ///
  /// In en, this message translates to:
  /// **'AI OCR technology to scan utility bills and invoices, automatically extracting consumption data (electricity, fuel, water) without tedious manual entry.'**
  String get feature2Desc;

  /// No description provided for @feature2Badge.
  ///
  /// In en, this message translates to:
  /// **'AI OCR'**
  String get feature2Badge;

  /// No description provided for @feature3Title.
  ///
  /// In en, this message translates to:
  /// **'Standardized Carbon Calculation'**
  String get feature3Title;

  /// No description provided for @feature3Desc.
  ///
  /// In en, this message translates to:
  /// **'GHG calculation engine across all three scopes: direct emissions (Scope 1), purchased energy (Scope 2), and value chain emissions (Scope 3).'**
  String get feature3Desc;

  /// No description provided for @feature3Badge.
  ///
  /// In en, this message translates to:
  /// **'Scope 1, 2, 3'**
  String get feature3Badge;

  /// No description provided for @feature4Title.
  ///
  /// In en, this message translates to:
  /// **'Department Allocation & Tracking'**
  String get feature4Title;

  /// No description provided for @feature4Desc.
  ///
  /// In en, this message translates to:
  /// **'Structure facility data and allocate KPIs across departments (Operations, Maintenance, HSE, HR) with multi-level audit approval workflows.'**
  String get feature4Desc;

  /// No description provided for @feature4Badge.
  ///
  /// In en, this message translates to:
  /// **'Workflow & Roles'**
  String get feature4Badge;

  /// No description provided for @feature5Title.
  ///
  /// In en, this message translates to:
  /// **'Supplier & Value Chain Governance'**
  String get feature5Title;

  /// No description provided for @feature5Desc.
  ///
  /// In en, this message translates to:
  /// **'Track supplier compliance with codes of conduct, evaluate supply chain sustainability, and support Scope 3 calculations for CBAM export compliance.'**
  String get feature5Desc;

  /// No description provided for @feature5Badge.
  ///
  /// In en, this message translates to:
  /// **'Supply & CBAM'**
  String get feature5Badge;

  /// No description provided for @feature6Title.
  ///
  /// In en, this message translates to:
  /// **'Certified Professional Reporting'**
  String get feature6Title;

  /// No description provided for @feature6Desc.
  ///
  /// In en, this message translates to:
  /// **'Generate official sustainability reports in one click (audit-ready PDF & Excel) aligned with international standards for investors and regulators.'**
  String get feature6Desc;

  /// No description provided for @feature6Badge.
  ///
  /// In en, this message translates to:
  /// **'Audit-Ready'**
  String get feature6Badge;

  /// No description provided for @workflowCategory.
  ///
  /// In en, this message translates to:
  /// **'Workflow'**
  String get workflowCategory;

  /// No description provided for @workflowTitle.
  ///
  /// In en, this message translates to:
  /// **'A Streamlined Journey from Raw Data to Certified Reports'**
  String get workflowTitle;

  /// No description provided for @workflowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Four integrated steps ensuring data accuracy, automated calculations, and rapid regulatory report generation with confidence.'**
  String get workflowSubtitle;

  /// No description provided for @workflowStepLabel.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get workflowStepLabel;

  /// No description provided for @step1Num.
  ///
  /// In en, this message translates to:
  /// **'01'**
  String get step1Num;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Data Collection & Entry'**
  String get step1Title;

  /// No description provided for @step1Desc.
  ///
  /// In en, this message translates to:
  /// **'Input consumption readings via interactive forms or upload PDF/image bills for instant AI OCR extraction.'**
  String get step1Desc;

  /// No description provided for @step2Num.
  ///
  /// In en, this message translates to:
  /// **'02'**
  String get step2Num;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Internal Audit & Validation'**
  String get step2Title;

  /// No description provided for @step2Desc.
  ///
  /// In en, this message translates to:
  /// **'Department heads and sustainability leads review entered data against source documents to guarantee data integrity.'**
  String get step2Desc;

  /// No description provided for @step3Num.
  ///
  /// In en, this message translates to:
  /// **'03'**
  String get step3Num;

  /// No description provided for @step3Title.
  ///
  /// In en, this message translates to:
  /// **'Automated Calculations'**
  String get step3Title;

  /// No description provided for @step3Desc.
  ///
  /// In en, this message translates to:
  /// **'Apply standard emission factors, calculate carbon footprints across all scopes, and generate KPIs and AI recommendations.'**
  String get step3Desc;

  /// No description provided for @step4Num.
  ///
  /// In en, this message translates to:
  /// **'04'**
  String get step4Num;

  /// No description provided for @step4Title.
  ///
  /// In en, this message translates to:
  /// **'Report Generation & Export'**
  String get step4Title;

  /// No description provided for @step4Desc.
  ///
  /// In en, this message translates to:
  /// **'Generate comprehensive ESG reports compliant with national and global requirements, ready for external audit.'**
  String get step4Desc;

  /// No description provided for @demoCategory.
  ///
  /// In en, this message translates to:
  /// **'Book a Demo'**
  String get demoCategory;

  /// No description provided for @demoTitle.
  ///
  /// In en, this message translates to:
  /// **'See Sustina in Action for Your Organization'**
  String get demoTitle;

  /// No description provided for @demoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Request a guided demonstration tailored to your sector. Explore automated Scope 1–3 carbon tracking, AI bill extraction, and audit-ready ESG reporting with our specialists.'**
  String get demoSubtitle;

  /// No description provided for @demoBenefit1Title.
  ///
  /// In en, this message translates to:
  /// **'Tailored Sector Walkthrough'**
  String get demoBenefit1Title;

  /// No description provided for @demoBenefit1Desc.
  ///
  /// In en, this message translates to:
  /// **'Live demo configured around your industry metrics, energy profile, and compliance targets.'**
  String get demoBenefit1Desc;

  /// No description provided for @demoBenefit2Title.
  ///
  /// In en, this message translates to:
  /// **'Live AI OCR & RAG Assistant'**
  String get demoBenefit2Title;

  /// No description provided for @demoBenefit2Desc.
  ///
  /// In en, this message translates to:
  /// **'Watch raw utility bills convert into verified emissions insights and actionable reductions.'**
  String get demoBenefit2Desc;

  /// No description provided for @demoBenefit3Title.
  ///
  /// In en, this message translates to:
  /// **'Governance & Team Architecture'**
  String get demoBenefit3Title;

  /// No description provided for @demoBenefit3Desc.
  ///
  /// In en, this message translates to:
  /// **'Review multi-department workflows, supplier scoring, and executive reporting exports.'**
  String get demoBenefit3Desc;

  /// No description provided for @demoTrustNote.
  ///
  /// In en, this message translates to:
  /// **'Response within 1 business day • Available in Arabic & English'**
  String get demoTrustNote;

  /// No description provided for @demoFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Your Live Demonstration'**
  String get demoFormTitle;

  /// No description provided for @demoFormSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fill in your contact details and our team will reach out to schedule a convenient session.'**
  String get demoFormSubtitle;

  /// No description provided for @demoSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Request Live Demo'**
  String get demoSubmitButton;

  /// No description provided for @demoSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Sending Request...'**
  String get demoSubmitting;

  /// No description provided for @demoSuccessBadge.
  ///
  /// In en, this message translates to:
  /// **'Demo Request Received'**
  String get demoSuccessBadge;

  /// No description provided for @demoSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank You! Your Demo Request Is Confirmed'**
  String get demoSuccessTitle;

  /// No description provided for @demoSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Our Sustina advisory team has received your demo request and will contact you shortly to coordinate the demonstration date and agenda.'**
  String get demoSuccessMessage;

  /// No description provided for @demoSuccessRef.
  ///
  /// In en, this message translates to:
  /// **'Reference ID'**
  String get demoSuccessRef;

  /// No description provided for @demoSuccessSchedule.
  ///
  /// In en, this message translates to:
  /// **'Preferred Timing'**
  String get demoSuccessSchedule;

  /// No description provided for @demoBookAnother.
  ///
  /// In en, this message translates to:
  /// **'Request Another Demo'**
  String get demoBookAnother;

  /// No description provided for @fieldFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fieldFullName;

  /// No description provided for @hintFullName.
  ///
  /// In en, this message translates to:
  /// **'e.g., Sarah Al-Qahtani'**
  String get hintFullName;

  /// No description provided for @fieldCompanyName.
  ///
  /// In en, this message translates to:
  /// **'Company Name'**
  String get fieldCompanyName;

  /// No description provided for @hintCompanyName.
  ///
  /// In en, this message translates to:
  /// **'e.g., Horizon Industrial Group'**
  String get hintCompanyName;

  /// No description provided for @fieldBusinessEmail.
  ///
  /// In en, this message translates to:
  /// **'Business Email'**
  String get fieldBusinessEmail;

  /// No description provided for @hintBusinessEmail.
  ///
  /// In en, this message translates to:
  /// **'name@company.com'**
  String get hintBusinessEmail;

  /// No description provided for @fieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get fieldPhone;

  /// No description provided for @hintPhone.
  ///
  /// In en, this message translates to:
  /// **'+966 5X XXX XXXX'**
  String get hintPhone;

  /// No description provided for @fieldJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Job Title / Position'**
  String get fieldJobTitle;

  /// No description provided for @hintJobTitle.
  ///
  /// In en, this message translates to:
  /// **'e.g., Sustainability Manager'**
  String get hintJobTitle;

  /// No description provided for @fieldIndustry.
  ///
  /// In en, this message translates to:
  /// **'Industry / Business Sector'**
  String get fieldIndustry;

  /// No description provided for @hintIndustry.
  ///
  /// In en, this message translates to:
  /// **'Select your industry sector'**
  String get hintIndustry;

  /// No description provided for @fieldPreferredDate.
  ///
  /// In en, this message translates to:
  /// **'Preferred Demo Date'**
  String get fieldPreferredDate;

  /// No description provided for @hintPreferredDate.
  ///
  /// In en, this message translates to:
  /// **'Select preferred date'**
  String get hintPreferredDate;

  /// No description provided for @fieldPreferredTime.
  ///
  /// In en, this message translates to:
  /// **'Preferred Time Slot'**
  String get fieldPreferredTime;

  /// No description provided for @timeSlotMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning (9 AM – 12 PM)'**
  String get timeSlotMorning;

  /// No description provided for @timeSlotAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon (12 PM – 4 PM)'**
  String get timeSlotAfternoon;

  /// No description provided for @timeSlotEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening (4 PM – 7 PM)'**
  String get timeSlotEvening;

  /// No description provided for @fieldNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional Requirements (Optional)'**
  String get fieldNotes;

  /// No description provided for @hintNotes.
  ///
  /// In en, this message translates to:
  /// **'Share target standards (GRI, CBAM), number of facilities, or questions...'**
  String get hintNotes;

  /// No description provided for @sectorManufacturing.
  ///
  /// In en, this message translates to:
  /// **'Industrial & Manufacturing'**
  String get sectorManufacturing;

  /// No description provided for @sectorEnergy.
  ///
  /// In en, this message translates to:
  /// **'Energy, Oil & Petrochemicals'**
  String get sectorEnergy;

  /// No description provided for @sectorRealEstate.
  ///
  /// In en, this message translates to:
  /// **'Real Estate & Construction'**
  String get sectorRealEstate;

  /// No description provided for @sectorLogistics.
  ///
  /// In en, this message translates to:
  /// **'Logistics & Transportation'**
  String get sectorLogistics;

  /// No description provided for @sectorFinance.
  ///
  /// In en, this message translates to:
  /// **'Banking & Financial Services'**
  String get sectorFinance;

  /// No description provided for @sectorRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail, Hospitality & Food'**
  String get sectorRetail;

  /// No description provided for @sectorHealthcare.
  ///
  /// In en, this message translates to:
  /// **'Healthcare & Pharmaceuticals'**
  String get sectorHealthcare;

  /// No description provided for @sectorTechnology.
  ///
  /// In en, this message translates to:
  /// **'Technology & Telecommunications'**
  String get sectorTechnology;

  /// No description provided for @sectorOther.
  ///
  /// In en, this message translates to:
  /// **'Other Business Sector'**
  String get sectorOther;

  /// No description provided for @sizeSmall.
  ///
  /// In en, this message translates to:
  /// **'1 – 50 Employees'**
  String get sizeSmall;

  /// No description provided for @sizeMedium.
  ///
  /// In en, this message translates to:
  /// **'51 – 250 Employees'**
  String get sizeMedium;

  /// No description provided for @sizeLarge.
  ///
  /// In en, this message translates to:
  /// **'251 – 1,000 Employees'**
  String get sizeLarge;

  /// No description provided for @sizeEnterprise.
  ///
  /// In en, this message translates to:
  /// **'1,000+ Employees'**
  String get sizeEnterprise;

  /// No description provided for @countrySaudi.
  ///
  /// In en, this message translates to:
  /// **'Saudi Arabia'**
  String get countrySaudi;

  /// No description provided for @countryEgypt.
  ///
  /// In en, this message translates to:
  /// **'Egypt'**
  String get countryEgypt;

  /// No description provided for @countryUae.
  ///
  /// In en, this message translates to:
  /// **'United Arab Emirates'**
  String get countryUae;

  /// No description provided for @countryQatar.
  ///
  /// In en, this message translates to:
  /// **'Qatar'**
  String get countryQatar;

  /// No description provided for @countryKuwait.
  ///
  /// In en, this message translates to:
  /// **'Kuwait'**
  String get countryKuwait;

  /// No description provided for @countryBahrain.
  ///
  /// In en, this message translates to:
  /// **'Bahrain'**
  String get countryBahrain;

  /// No description provided for @countryOman.
  ///
  /// In en, this message translates to:
  /// **'Oman'**
  String get countryOman;

  /// No description provided for @countryJordan.
  ///
  /// In en, this message translates to:
  /// **'Jordan'**
  String get countryJordan;

  /// No description provided for @countryOther.
  ///
  /// In en, this message translates to:
  /// **'Other Country'**
  String get countryOther;

  /// No description provided for @valRequiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get valRequiredField;

  /// No description provided for @valNameMin.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 2 characters'**
  String get valNameMin;

  /// No description provided for @valEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Business email is required'**
  String get valEmailRequired;

  /// No description provided for @valEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get valEmailInvalid;

  /// No description provided for @valPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get valPhoneRequired;

  /// No description provided for @valPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get valPhoneInvalid;

  /// No description provided for @valIndustryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select an industry sector'**
  String get valIndustryRequired;

  /// No description provided for @valCountryRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a country'**
  String get valCountryRequired;

  /// No description provided for @valCompanySizeRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select company size'**
  String get valCompanySizeRequired;

  /// No description provided for @regOverviewCategory.
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get regOverviewCategory;

  /// No description provided for @regOverviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Transparent 6-Stage Company Registration Without Upfront Payment'**
  String get regOverviewTitle;

  /// No description provided for @regOverviewSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Joining Sustina begins with submitting your basic company profile. No package selection or immediate billing happens online — our admin team collaborates with you first to tailor the right plan.'**
  String get regOverviewSubtitle;

  /// No description provided for @regOverviewNoPaymentPill.
  ///
  /// In en, this message translates to:
  /// **'No immediate subscription or automatic payment upon registration'**
  String get regOverviewNoPaymentPill;

  /// No description provided for @regOverviewCta.
  ///
  /// In en, this message translates to:
  /// **'Register Your Company'**
  String get regOverviewCta;

  /// No description provided for @regOverviewSecondaryCta.
  ///
  /// In en, this message translates to:
  /// **'Book a Demo First'**
  String get regOverviewSecondaryCta;

  /// No description provided for @regPageBackToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Landing Page'**
  String get regPageBackToHome;

  /// No description provided for @regPageBadge.
  ///
  /// In en, this message translates to:
  /// **'Consultative Enterprise Onboarding'**
  String get regPageBadge;

  /// No description provided for @regPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Register Your Company on Sustina'**
  String get regPageTitle;

  /// No description provided for @regPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Start by sharing your organization\'s basic details. Our administration team will follow up to assess your ESG requirements and recommend the optimal subscription package before payment and activation.'**
  String get regPageSubtitle;

  /// No description provided for @regTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'6-Stage Onboarding Roadmap'**
  String get regTimelineTitle;

  /// No description provided for @regTimelineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Follow every milestone from initial request to full workspace activation'**
  String get regTimelineSubtitle;

  /// No description provided for @regStage1Title.
  ///
  /// In en, this message translates to:
  /// **'Submit Basic Company Info'**
  String get regStage1Title;

  /// No description provided for @regStage1Desc.
  ///
  /// In en, this message translates to:
  /// **'Provide company name, official email, contact person, sector, size, and country.'**
  String get regStage1Desc;

  /// No description provided for @regStage2Title.
  ///
  /// In en, this message translates to:
  /// **'Registration Confirmation'**
  String get regStage2Title;

  /// No description provided for @regStage2Desc.
  ///
  /// In en, this message translates to:
  /// **'Receive instant confirmation that your onboarding request has been logged.'**
  String get regStage2Desc;

  /// No description provided for @regStage3Title.
  ///
  /// In en, this message translates to:
  /// **'Admin Follow-Up & Assessment'**
  String get regStage3Title;

  /// No description provided for @regStage3Desc.
  ///
  /// In en, this message translates to:
  /// **'Sustina administration contacts you to evaluate business needs and recommend packages.'**
  String get regStage3Desc;

  /// No description provided for @regStage4Title.
  ///
  /// In en, this message translates to:
  /// **'Package Selection & Agreement'**
  String get regStage4Title;

  /// No description provided for @regStage4Desc.
  ///
  /// In en, this message translates to:
  /// **'Your team and our administration agree on the most suitable subscription package.'**
  String get regStage4Desc;

  /// No description provided for @regStage5Title.
  ///
  /// In en, this message translates to:
  /// **'Package Payment'**
  String get regStage5Title;

  /// No description provided for @regStage5Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete invoice payment according to the agreed package terms.'**
  String get regStage5Desc;

  /// No description provided for @regStage6Title.
  ///
  /// In en, this message translates to:
  /// **'Platform Activation'**
  String get regStage6Title;

  /// No description provided for @regStage6Desc.
  ///
  /// In en, this message translates to:
  /// **'Once payment is confirmed, the admin team activates your organization\'s platform access.'**
  String get regStage6Desc;

  /// No description provided for @regStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active Step'**
  String get regStatusActive;

  /// No description provided for @regStatusCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get regStatusCompleted;

  /// No description provided for @regStatusNext.
  ///
  /// In en, this message translates to:
  /// **'Up Next'**
  String get regStatusNext;

  /// No description provided for @regStatusUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get regStatusUpcoming;

  /// No description provided for @regFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Stage 1 — Basic Company Information'**
  String get regFormTitle;

  /// No description provided for @regFormNotice.
  ///
  /// In en, this message translates to:
  /// **'Important: No package selection or payment is required during initial registration. Our administration team will coordinate with you after submission.'**
  String get regFormNotice;

  /// No description provided for @fieldCompanyEmail.
  ///
  /// In en, this message translates to:
  /// **'Company Email'**
  String get fieldCompanyEmail;

  /// No description provided for @hintCompanyEmail.
  ///
  /// In en, this message translates to:
  /// **'info@company.com'**
  String get hintCompanyEmail;

  /// No description provided for @fieldContactPerson.
  ///
  /// In en, this message translates to:
  /// **'Contact Person\'s Full Name'**
  String get fieldContactPerson;

  /// No description provided for @hintContactPerson.
  ///
  /// In en, this message translates to:
  /// **'e.g., Khalid Al-Harbi'**
  String get hintContactPerson;

  /// No description provided for @fieldCompanySize.
  ///
  /// In en, this message translates to:
  /// **'Company Size'**
  String get fieldCompanySize;

  /// No description provided for @hintCompanySize.
  ///
  /// In en, this message translates to:
  /// **'Select employee count range'**
  String get hintCompanySize;

  /// No description provided for @fieldCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get fieldCountry;

  /// No description provided for @hintCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get hintCountry;

  /// No description provided for @fieldRegNotes.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes or ESG Scope (Optional)'**
  String get fieldRegNotes;

  /// No description provided for @hintRegNotes.
  ///
  /// In en, this message translates to:
  /// **'Briefly share number of branches, facilities, or key sustainability targets...'**
  String get hintRegNotes;

  /// No description provided for @regSubmitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit Company Registration'**
  String get regSubmitButton;

  /// No description provided for @regSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting Registration...'**
  String get regSubmitting;

  /// No description provided for @regSuccessBadge.
  ///
  /// In en, this message translates to:
  /// **'Stage 2 Complete • Awaiting Admin Follow-up'**
  String get regSuccessBadge;

  /// No description provided for @regSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Registration Request Received Successfully!'**
  String get regSuccessTitle;

  /// No description provided for @regSuccessDesc.
  ///
  /// In en, this message translates to:
  /// **'Thank you for registering your organization with Sustina. No package has been charged or locked in. Our administration team will contact you shortly to understand your business requirements, evaluate your ESG needs, and recommend the most suitable subscription package.'**
  String get regSuccessDesc;

  /// No description provided for @regSuccessNextTitle.
  ///
  /// In en, this message translates to:
  /// **'What Happens Next in Your Onboarding Journey?'**
  String get regSuccessNextTitle;

  /// No description provided for @regSuccessNextBody.
  ///
  /// In en, this message translates to:
  /// **'Our administration team will reach out to discuss available packages, finalize the right plan together, coordinate payment upon agreement, and activate full platform access for your organization.'**
  String get regSuccessNextBody;

  /// No description provided for @regSuccessRefLabel.
  ///
  /// In en, this message translates to:
  /// **'Registration Reference'**
  String get regSuccessRefLabel;

  /// No description provided for @regSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Submitted Company Profile'**
  String get regSummaryTitle;

  /// No description provided for @regBackToLanding.
  ///
  /// In en, this message translates to:
  /// **'Return to Landing Page'**
  String get regBackToLanding;

  /// No description provided for @regRegisterAnother.
  ///
  /// In en, this message translates to:
  /// **'Submit Another Registration'**
  String get regRegisterAnother;

  /// No description provided for @loginPlaceholderTitle.
  ///
  /// In en, this message translates to:
  /// **'Organization Portal Sign In'**
  String get loginPlaceholderTitle;

  /// No description provided for @loginPlaceholderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The sign-in portal is dedicated to activated enterprise workspaces. If your organization has not been onboarded yet, please submit a registration request first.'**
  String get loginPlaceholderSubtitle;

  /// No description provided for @backToLanding.
  ///
  /// In en, this message translates to:
  /// **'Return to Landing Page'**
  String get backToLanding;

  /// No description provided for @ctaBadge.
  ///
  /// In en, this message translates to:
  /// **'Get Started Today | Sustainable Impact'**
  String get ctaBadge;

  /// No description provided for @ctaTitle.
  ///
  /// In en, this message translates to:
  /// **'Ready to Lead Sustainability in Your Organization?'**
  String get ctaTitle;

  /// No description provided for @ctaSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Join pioneering enterprises that rely on Sustina to automate sustainability reporting, reduce carbon emissions, and satisfy regulatory mandates.'**
  String get ctaSubtitle;

  /// No description provided for @ctaRegisterButton.
  ///
  /// In en, this message translates to:
  /// **'Register Your Company'**
  String get ctaRegisterButton;

  /// No description provided for @ctaLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get ctaLoginButton;

  /// No description provided for @ctaGuarantees.
  ///
  /// In en, this message translates to:
  /// **'✓ Multi-department role-based access   •   ✓ ESG & CBAM compliant   •   ✓ Full Arabic & English support'**
  String get ctaGuarantees;

  /// No description provided for @footerDesc.
  ///
  /// In en, this message translates to:
  /// **'Advanced cloud platform for sustainability data management, carbon footprint calculation, and AI-powered ESG reporting for commercial and industrial enterprises.'**
  String get footerDesc;

  /// No description provided for @footerPlatformLinks.
  ///
  /// In en, this message translates to:
  /// **'Platform Navigation'**
  String get footerPlatformLinks;

  /// No description provided for @footerPortalLinks.
  ///
  /// In en, this message translates to:
  /// **'Platform Portal'**
  String get footerPortalLinks;

  /// No description provided for @footerLinkAbout.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get footerLinkAbout;

  /// No description provided for @footerLinkPillars.
  ///
  /// In en, this message translates to:
  /// **'ESG Pillars'**
  String get footerLinkPillars;

  /// No description provided for @footerLinkFeatures.
  ///
  /// In en, this message translates to:
  /// **'Capabilities'**
  String get footerLinkFeatures;

  /// No description provided for @footerLinkWorkflow.
  ///
  /// In en, this message translates to:
  /// **'Workflow'**
  String get footerLinkWorkflow;

  /// No description provided for @footerLinkDemo.
  ///
  /// In en, this message translates to:
  /// **'Book a Demo'**
  String get footerLinkDemo;

  /// No description provided for @footerLinkOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Onboarding'**
  String get footerLinkOnboarding;

  /// No description provided for @footerLinkLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get footerLinkLogin;

  /// No description provided for @footerLinkRegister.
  ///
  /// In en, this message translates to:
  /// **'Register Company'**
  String get footerLinkRegister;

  /// No description provided for @footerLinkTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get footerLinkTerms;

  /// No description provided for @footerLinkPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get footerLinkPrivacy;

  /// No description provided for @footerContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact & Technical Support'**
  String get footerContactTitle;

  /// No description provided for @footerContactTeam.
  ///
  /// In en, this message translates to:
  /// **'ESG & Compliance Support Team'**
  String get footerContactTeam;

  /// No description provided for @footerContactLang.
  ///
  /// In en, this message translates to:
  /// **'Available in Arabic & English'**
  String get footerContactLang;

  /// No description provided for @footerPolicyDialogContent.
  ///
  /// In en, this message translates to:
  /// **'According to the System Requirements Specification (SRS), all institutional data stored in Sustina adheres to certified privacy, security, and strict data confidentiality protocols.'**
  String get footerPolicyDialogContent;

  /// No description provided for @footerCloseDialog.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get footerCloseDialog;

  /// No description provided for @footerEsgPillars.
  ///
  /// In en, this message translates to:
  /// **'ESG Pillars'**
  String get footerEsgPillars;

  /// No description provided for @footerPillarE.
  ///
  /// In en, this message translates to:
  /// **'Environmental (Scope 1, 2, 3)'**
  String get footerPillarE;

  /// No description provided for @footerPillarS.
  ///
  /// In en, this message translates to:
  /// **'Social & Occupational Safety'**
  String get footerPillarS;

  /// No description provided for @footerPillarG.
  ///
  /// In en, this message translates to:
  /// **'Governance & Compliance'**
  String get footerPillarG;

  /// No description provided for @footerContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get footerContact;

  /// No description provided for @footerEmail.
  ///
  /// In en, this message translates to:
  /// **'support@sustina.io'**
  String get footerEmail;

  /// No description provided for @footerLocation.
  ///
  /// In en, this message translates to:
  /// **'Kingdom of Saudi Arabia | Egypt'**
  String get footerLocation;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Sustina Platform. All rights reserved.'**
  String get footerCopyright;

  /// No description provided for @footerPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get footerPrivacy;

  /// No description provided for @footerTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get footerTerms;

  /// No description provided for @floatingAiButton.
  ///
  /// In en, this message translates to:
  /// **'Sustina AI Assistant'**
  String get floatingAiButton;

  /// No description provided for @aiModalTitle.
  ///
  /// In en, this message translates to:
  /// **'Sustina AI Smart Assistant'**
  String get aiModalTitle;

  /// No description provided for @aiModalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Powered by LLM & RAG for ESG compliance queries'**
  String get aiModalSubtitle;

  /// No description provided for @aiModalWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Sustina! Once signed in, our AI Assistant helps you query all energy consumption metrics, emissions, and personalized carbon reduction recommendations.'**
  String get aiModalWelcome;

  /// No description provided for @aiModalButton.
  ///
  /// In en, this message translates to:
  /// **'Register Organization to Activate AI'**
  String get aiModalButton;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get themeDark;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get themeSystem;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get navDashboard;

  /// No description provided for @navReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get navReports;

  /// No description provided for @navData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get navData;

  /// No description provided for @userRoleAdmin.
  ///
  /// In en, this message translates to:
  /// **'Company Admin'**
  String get userRoleAdmin;

  /// No description provided for @refHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'An Integrated Platform for Managing & Analyzing Sustainability Data'**
  String get refHeroTitle;

  /// No description provided for @refHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Together towards a more sustainable future'**
  String get refHeroSubtitle;

  /// No description provided for @refHeroCta.
  ///
  /// In en, this message translates to:
  /// **'Register Company'**
  String get refHeroCta;

  /// No description provided for @featureSmartAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Smart Analytics'**
  String get featureSmartAnalytics;

  /// No description provided for @featureComprehensiveReports.
  ///
  /// In en, this message translates to:
  /// **'Comprehensive Reports'**
  String get featureComprehensiveReports;

  /// No description provided for @featureContinuousTracking.
  ///
  /// In en, this message translates to:
  /// **'Continuous Tracking'**
  String get featureContinuousTracking;

  /// No description provided for @dashSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Environmental Performance Summary'**
  String get dashSummaryTitle;

  /// No description provided for @dashPeriodLast12Months.
  ///
  /// In en, this message translates to:
  /// **'Last 12 Months'**
  String get dashPeriodLast12Months;

  /// No description provided for @dashKpiEsgScore.
  ///
  /// In en, this message translates to:
  /// **'ESG Score'**
  String get dashKpiEsgScore;

  /// No description provided for @dashKpiWater.
  ///
  /// In en, this message translates to:
  /// **'Water Efficiency'**
  String get dashKpiWater;

  /// No description provided for @dashKpiEmissions.
  ///
  /// In en, this message translates to:
  /// **'Total Emissions'**
  String get dashKpiEmissions;

  /// No description provided for @dashChartTitle.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Performance Over Time'**
  String get dashChartTitle;

  /// No description provided for @dashTabMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get dashTabMonthly;

  /// No description provided for @dashTabQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get dashTabQuarterly;

  /// No description provided for @dashTabAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get dashTabAnnual;

  /// No description provided for @dashBannerText.
  ///
  /// In en, this message translates to:
  /// **'A sustainable enterprise .. for a better future'**
  String get dashBannerText;

  /// No description provided for @dashMonthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get dashMonthJan;

  /// No description provided for @dashMonthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get dashMonthFeb;

  /// No description provided for @dashMonthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get dashMonthMar;

  /// No description provided for @dashMonthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get dashMonthApr;

  /// No description provided for @dashMonthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get dashMonthMay;

  /// No description provided for @dashMonthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get dashMonthJun;

  /// No description provided for @heroCtaDemo.
  ///
  /// In en, this message translates to:
  /// **'Book a Demo'**
  String get heroCtaDemo;

  /// No description provided for @heroTrustLiveBadge.
  ///
  /// In en, this message translates to:
  /// **'Certified AI-Powered Sustainability Platform'**
  String get heroTrustLiveBadge;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
