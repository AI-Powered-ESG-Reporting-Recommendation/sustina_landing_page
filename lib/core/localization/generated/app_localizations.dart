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
  /// **'Smart Capabilities'**
  String get navFeatures;

  /// No description provided for @navWorkflow.
  ///
  /// In en, this message translates to:
  /// **'Data Workflow'**
  String get navWorkflow;

  /// No description provided for @navLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get navLogin;

  /// No description provided for @navRegister.
  ///
  /// In en, this message translates to:
  /// **'Register Organization'**
  String get navRegister;

  /// No description provided for @navContact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get navContact;

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
  /// **'An integrated enterprise platform connecting operations, HSE, and governance to streamline data gathering, automate carbon calculations (Scope 1, 2, 3), and generate audit-ready compliance reports.'**
  String get heroSubtitle;

  /// No description provided for @heroCtaStart.
  ///
  /// In en, this message translates to:
  /// **'Start Now — Register'**
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
  /// **'CBAM & Grievance Ready'**
  String get heroTrustPill4;

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
  /// **'Three ESG Core Dimensions'**
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
  /// **'Smart Platform Capabilities'**
  String get featuresCategory;

  /// No description provided for @featuresTitle.
  ///
  /// In en, this message translates to:
  /// **'Advanced Tools for Smart, Connected Sustainability Management'**
  String get featuresTitle;

  /// No description provided for @featuresSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sustina is designed to combine effortless data entry, powerful AI analytics, and rigorous compliance with regulatory standards.'**
  String get featuresSubtitle;

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
  /// **'AI OCR Extraction'**
  String get feature2Badge;

  /// No description provided for @feature3Title.
  ///
  /// In en, this message translates to:
  /// **'Standardized Carbon Footprint Calculation'**
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
  /// **'Department Allocation & Task Tracking'**
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
  /// **'Supply Chain & CBAM'**
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
  /// **'Audit-Ready Reports'**
  String get feature6Badge;

  /// No description provided for @workflowCategory.
  ///
  /// In en, this message translates to:
  /// **'Sustainability Data Lifecycle'**
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
  /// **'Register New Organization'**
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
  /// **'About Platform'**
  String get footerLinkAbout;

  /// No description provided for @footerLinkPillars.
  ///
  /// In en, this message translates to:
  /// **'Three ESG Pillars'**
  String get footerLinkPillars;

  /// No description provided for @footerLinkFeatures.
  ///
  /// In en, this message translates to:
  /// **'Smart Capabilities'**
  String get footerLinkFeatures;

  /// No description provided for @footerLinkWorkflow.
  ///
  /// In en, this message translates to:
  /// **'Data Workflow'**
  String get footerLinkWorkflow;

  /// No description provided for @footerLinkLogin.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get footerLinkLogin;

  /// No description provided for @footerLinkRegister.
  ///
  /// In en, this message translates to:
  /// **'Register Organization'**
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
  /// **'Start Now'**
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
