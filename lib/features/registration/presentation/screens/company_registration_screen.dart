import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/di/service_locator.dart';
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
import 'package:suatina_web_project/features/registration/logic/registration_cubit.dart';
import 'package:suatina_web_project/features/registration/logic/registration_state.dart';
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isArabic = context.isArabic;
    final isRtl = context.isRtl;
    final isDesktop = context.isDesktopOrLarger;

    return BlocProvider<RegistrationCubit>(
      create: (_) => getIt<RegistrationCubit>(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          if (state.isSuccess) {
            _scrollToTop();
          }
        },
        builder: (context, state) {
          final cubit = context.read<RegistrationCubit>();
          final isSubmitted = state.isSuccess;

          return Scaffold(
            backgroundColor: colors.background,
            body: Stack(
              children: [
                // Ambient Radial Background Glows for Enterprise SaaS depth
                Positioned(
                  top: -120,
                  left: isRtl ? null : -100,
                  right: isRtl ? -100 : null,
                  child: IgnorePointer(
                    child: Container(
                      width: 520,
                      height: 520,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colors.primary500.withValues(
                              alpha: isDark ? 0.12 : 0.08,
                            ),
                            colors.primary500.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: isRtl ? -80 : null,
                  right: isRtl ? null : -80,
                  child: IgnorePointer(
                    child: Container(
                      width: 480,
                      height: 480,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            colors.secondary500.withValues(
                              alpha: isDark ? 0.08 : 0.06,
                            ),
                            colors.secondary500.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Main Column Layout
                Column(
                  children: [
                    // Top Frosted Glassmorphic Navigation Bar
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: colors.white.withValues(
                              alpha: isDark ? 0.88 : 0.92,
                            ),
                            border: Border(
                              bottom: BorderSide(
                                color: colors.grey200.withValues(
                                  alpha: isDark ? 0.7 : 0.9,
                                ),
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: colors.black.withValues(
                                  alpha: isDark ? 0.25 : 0.03,
                                ),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: AdaptiveContentContainer(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsivePadding.pageHorizontal(
                                context,
                              ),
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                // Brand Logo
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
                                            logoSize:
                                                context.isMobile ? 28 : 34,
                                            wordmarkFontSize:
                                                context.isMobile ? 17 : 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Institutional Trust Badge (Desktop Only)
                                if (isDesktop) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? colors.primary100.withValues(
                                              alpha: 0.7,
                                            )
                                          : colors.primary100,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: colors.primary500.withValues(
                                          alpha: 0.35,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.verified_user_rounded,
                                          size: 15,
                                          color: isDark
                                              ? colors.primary700
                                              : colors.primary600,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          isArabic
                                              ? 'بوابة التسجيل المؤسسي المعتمدة'
                                              : 'Official Enterprise Onboarding',
                                          style: AppTextStyles.font12Bold
                                              .copyWith(
                                            color: isDark
                                                ? colors.primary700
                                                : colors.primary600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],

                                // Language Toggle Pill
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: colors.grey200),
                                  ),
                                  child: TextButton.icon(
                                    onPressed: () => context
                                        .read<LocaleCubit>()
                                        .toggleLocale(),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: context.isMobile ? 8 : 12,
                                        vertical: 6,
                                      ),
                                      minimumSize: Size.zero,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    icon: Icon(
                                      Icons.language_rounded,
                                      size: 16,
                                      color: isDark
                                          ? colors.primary700
                                          : colors.primary600,
                                    ),
                                    label: Text(
                                      context.isMobile
                                          ? (isArabic ? 'EN' : 'AR')
                                          : (isArabic
                                              ? l10n.langNameEn
                                              : l10n.langNameAr),
                                      style: AppTextStyles.font12Bold.copyWith(
                                        color: colors.neutral900,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                // Theme Toggle Button
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: colors.grey200),
                                  ),
                                  child: IconButton(
                                    tooltip: l10n.themeModeTooltip,
                                    constraints: const BoxConstraints(
                                      minWidth: 36,
                                      minHeight: 36,
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    onPressed: () => context
                                        .read<ThemeCubit>()
                                        .toggleTheme(),
                                    icon: Icon(
                                      isDark
                                          ? Icons.wb_sunny_rounded
                                          : Icons.nightlight_round,
                                      size: 18,
                                      color: isDark
                                          ? colors.secondary500
                                          : colors.primary600,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),

                                // Back to Landing Button
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: OutlinedButton.icon(
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
                                ),
                              ],
                            ),
                          ),
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
                              mobile: 24,
                              tablet: 36,
                              desktop: 48,
                            ),
                          ),
                          child: Column(
                            children: [
                              // Hero Intro (Notice: showBadge is false by default in SustinaSectionHeader)
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
                                height: context.responsiveValue(
                                  mobile: 24,
                                  desktop: 40,
                                ),
                              ),

                              if (isDesktop)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Form OR Confirmation View
                                    Expanded(
                                      flex: 13,
                                      child: _buildFormOrConfirmation(
                                        state,
                                        cubit,
                                      ),
                                    ),
                                    const SizedBox(width: 32),

                                    // Live 6-Stage Animated Stepper Timeline & Security Info
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
                                    _buildFormOrConfirmation(state, cubit),
                                    const SizedBox(height: 28),
                                    RegistrationStepperTimeline(
                                      isSubmitted: isSubmitted,
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 48),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFormOrConfirmation(
    RegistrationState state,
    RegistrationCubit cubit,
  ) {
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
      child: state.registrationResponse == null
          ? const RegistrationFormCard(
              key: ValueKey('reg_form'),
            )
          : RegistrationSuccessView(
              key: const ValueKey('reg_success'),
              response: state.registrationResponse!,
              onReset: cubit.reset,
            ),
    );
  }
}
