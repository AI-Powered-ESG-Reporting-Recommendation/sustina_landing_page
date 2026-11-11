import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/localization/locale_cubit.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_cubit.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/registration/presentation/models/company_registration_data.dart';
import 'package:suatina_web_project/features/registration/presentation/widgets/registration_form_card.dart';
import 'package:suatina_web_project/features/registration/presentation/widgets/registration_stepper_timeline.dart';
import 'package:suatina_web_project/features/registration/presentation/widgets/registration_success_view.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  const CompanyRegistrationScreen({super.key});

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends State<CompanyRegistrationScreen> {
  final ScrollController _scrollController = ScrollController();

  bool _isSubmitting = false;
  CompanyRegistrationData? _submittedData;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistrationSubmit(CompanyRegistrationData rawData) async {
    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    final refNum = 1000 + math.Random().nextInt(8999);
    setState(() {
      _isSubmitting = false;
      _submittedData = CompanyRegistrationData(
        referenceCode: 'REG-2026-$refNum',
        companyName: rawData.companyName,
        companyEmail: rawData.companyEmail,
        contactPerson: rawData.contactPerson,
        phone: rawData.phone,
        industryId: rawData.industryId,
        companySizeId: rawData.companySizeId,
        countryId: rawData.countryId,
        notes: rawData.notes,
      );
    });

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _resetRegistration() {
    setState(() {
      _submittedData = null;
      _isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isArabic = context.isArabic;
    final isRtl = context.isRtl;
    final isDesktop = context.isDesktopOrLarger;
    final isSubmitted = _submittedData != null;

    return Scaffold(
      backgroundColor: colors.background,
      body: Column(
        children: [
          // Top Branded Navigation Strip
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.white.withValues(alpha: isDark ? 0.94 : 0.96),
              border: Border(bottom: BorderSide(color: colors.grey200)),
            ),
            child: AdaptiveContentContainer(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsivePadding.pageHorizontal(context),
                vertical: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => context.go(Routes.landing),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SustinaBrandLogo(
                              logoSize: context.isMobile ? 28 : 32,
                              wordmarkFontSize: context.isMobile ? 17 : 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Language Toggle
                  TextButton.icon(
                    onPressed: () => context.read<LocaleCubit>().toggleLocale(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.isMobile ? 6 : 10,
                      ),
                      minimumSize: Size.zero,
                    ),
                    icon: Icon(
                      Icons.language_rounded,
                      size: 16,
                      color: isDark ? colors.primary700 : colors.primary600,
                    ),
                    label: Text(
                      context.isMobile
                          ? (isArabic ? 'EN' : 'AR')
                          : (isArabic ? l10n.langNameEn : l10n.langNameAr),
                      style: AppTextStyles.font12Bold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),

                  // Theme Toggle
                  IconButton(
                    tooltip: l10n.themeModeTooltip,
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: const EdgeInsets.all(6),
                    onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                    icon: Icon(
                      isDark
                          ? Icons.wb_sunny_rounded
                          : Icons.nightlight_round,
                      size: 19,
                      color: isDark ? colors.secondary500 : colors.primary600,
                    ),
                  ),
                  const SizedBox(width: 6),

                  // Back to Landing Button
                  OutlinedButton.icon(
                    onPressed: () => context.go(Routes.landing),
                    icon: Icon(
                      isRtl
                          ? Icons.arrow_forward_rounded
                          : Icons.arrow_back_rounded,
                      size: 16,
                    ),
                    label: Text(
                      context.isMobile
                          ? l10n.navHome
                          : l10n.regPageBackToHome,
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.neutral900,
                      side: BorderSide(color: colors.grey300),
                      padding: EdgeInsets.symmetric(
                        horizontal: context.isMobile ? 10 : 16,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: AppTextStyles.font12Bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Scrollable Registration Workspace
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: AdaptiveContentContainer(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsivePadding.pageHorizontal(context),
                  vertical: context.responsiveValue<double>(
                    mobile: 28,
                    tablet: 40,
                    desktop: 52,
                  ),
                ),
                child: Column(
                  children: [
                    // Hero Intro
                    AppRevealAnimation(
                      triggerOnVisible: false,
                      child: SustinaSectionHeader(
                        category: l10n.regPageBadge,
                        title: l10n.regPageTitle,
                        subtitle: l10n.regPageSubtitle,
                        badgeSvgPath: AppIcons.organization,
                        useSecondaryAccent: true,
                      ),
                    ),
                    SizedBox(
                      height: context.responsiveValue(mobile: 28, desktop: 44),
                    ),

                    if (isDesktop)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Form OR Stage 2 Confirmation View
                          Expanded(
                            flex: 12,
                            child: _buildFormOrConfirmation(),
                          ),
                          const SizedBox(width: 30),

                          // Live 6-Stage Animated Stepper Timeline
                          Expanded(
                            flex: 9,
                            child: RegistrationStepperTimeline(
                              isSubmitted: isSubmitted,
                            ),
                          ),
                        ],
                      )
                    else
                      Column(
                        children: [
                          _buildFormOrConfirmation(),
                          const SizedBox(height: 26),
                          RegistrationStepperTimeline(
                            isSubmitted: isSubmitted,
                          ),
                        ],
                      ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormOrConfirmation() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 450),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: _submittedData == null
          ? RegistrationFormCard(
              key: const ValueKey('reg_form'),
              isSubmitting: _isSubmitting,
              onSubmit: _handleRegistrationSubmit,
            )
          : RegistrationSuccessView(
              key: const ValueKey('reg_success'),
              data: _submittedData!,
              onReset: _resetRegistration,
            ),
    );
  }
}

