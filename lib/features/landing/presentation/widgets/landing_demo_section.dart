import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/helpers/app_validators.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';

class LandingDemoSection extends StatefulWidget {
  const LandingDemoSection({super.key});

  @override
  State<LandingDemoSection> createState() => _LandingDemoSectionState();
}

class _LandingDemoSectionState extends State<LandingDemoSection> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _companyController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _jobTitleController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedIndustry;
  DateTime? _preferredDate;
  String _preferredTimeSlot = 'morning';

  bool _isSubmitting = false;
  bool _isSubmitted = false;
  String _referenceCode = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _companyController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _jobTitleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _preferredDate ?? now.add(const Duration(days: 2));
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: now.add(const Duration(days: 120)),
    );
    if (picked != null && mounted) {
      setState(() => _preferredDate = picked);
    }
  }

  Future<void> _submitDemoRequest() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;

    final randomSuffix = 1000 + math.Random().nextInt(8999);
    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
      _referenceCode = 'DEM-2026-$randomSuffix';
    });
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _fullNameController.clear();
    _companyController.clear();
    _emailController.clear();
    _phoneController.clear();
    _jobTitleController.clear();
    _notesController.clear();
    setState(() {
      _selectedIndustry = null;
      _preferredDate = null;
      _preferredTimeSlot = 'morning';
      _isSubmitted = false;
      _referenceCode = '';
    });
  }

  String _timeSlotLabel(AppLocalizations l10n, String id) {
    return switch (id) {
      'afternoon' => l10n.timeSlotAfternoon,
      'evening' => l10n.timeSlotEvening,
      _ => l10n.timeSlotMorning,
    };
  }

  String _formattedDate(BuildContext context) {
    if (_preferredDate == null) return '';
    final locale = Localizations.localeOf(context).toString();
    return DateFormat.yMMMd(locale).format(_preferredDate!);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;

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
              category: l10n.demoCategory,
              title: l10n.demoTitle,
              subtitle: l10n.demoSubtitle,
              badgeSvgPath: AppIcons.chat,
            ),
            SizedBox(height: context.responsiveValue(mobile: 32, desktop: 52)),

            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 9,
                    child: AppRevealAnimation(
                      delay: const Duration(milliseconds: 60),
                      child: _DemoValuePropositionPanel(l10n: l10n),
                    ),
                  ),
                  const SizedBox(width: 36),
                  Expanded(
                    flex: 12,
                    child: AppRevealAnimation(
                      delay: const Duration(milliseconds: 140),
                      child: _buildFormOrSuccessCard(context),
                    ),
                  ),
                ],
              )
            else
              Column(
                children: [
                  AppRevealAnimation(
                    child: _DemoValuePropositionPanel(l10n: l10n),
                  ),
                  const SizedBox(height: 28),
                  AppRevealAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: _buildFormOrSuccessCard(context),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormOrSuccessCard(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _isSubmitted
              ? colors.primary500.withValues(alpha: 0.55)
              : colors.grey200,
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.30 : 0.05),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 420),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.97, end: 1.0).animate(animation),
              child: child,
            ),
          );
        },
        child: _isSubmitted
            ? _buildSuccessState(context)
            : _buildFormState(context),
      ),
    );
  }

  Widget _buildFormState(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isMobile = context.isMobile;
    final isDark = context.isDarkMode;
    final industries = SustinaFormCatalog.industries(l10n);

    final timeSlots = [
      ('morning', l10n.timeSlotMorning),
      ('afternoon', l10n.timeSlotAfternoon),
      ('evening', l10n.timeSlotEvening),
    ];

    Widget rowOrStacked(Widget first, Widget second) {
      if (isMobile) {
        return Column(
          children: [
            first,
            const SizedBox(height: 16),
            second,
          ],
        );
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: first),
          const SizedBox(width: 16),
          Expanded(child: second),
        ],
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('demo_form'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.demoFormTitle,
            style: AppTextStyles.font20Bold.copyWith(
              color: colors.neutral900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.demoFormSubtitle,
            style: AppTextStyles.font14Regular.copyWith(
              color: colors.neutral600,
            ),
          ),
          const SizedBox(height: 22),

          rowOrStacked(
            SustinaFormField(
              controller: _fullNameController,
              label: l10n.fieldFullName,
              hint: l10n.hintFullName,
              prefixIcon: Icons.person_outline_rounded,
              validator: (v) => AppValidators.validateName(
                v,
                requiredMessage: l10n.valRequiredField,
                minLengthMessage: l10n.valNameMin,
              ),
            ),
            SustinaFormField(
              controller: _companyController,
              label: l10n.fieldCompanyName,
              hint: l10n.hintCompanyName,
              prefixIcon: Icons.business_rounded,
              prefixSvgPath: AppIcons.organization,
              validator: (v) => AppValidators.validateName(
                v,
                requiredMessage: l10n.valRequiredField,
                minLengthMessage: l10n.valNameMin,
              ),
            ),
          ),
          const SizedBox(height: 16),

          rowOrStacked(
            SustinaFormField(
              controller: _emailController,
              label: l10n.fieldBusinessEmail,
              hint: l10n.hintBusinessEmail,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (v) => AppValidators.validateEmail(
                v,
                requiredMessage: l10n.valEmailRequired,
                invalidMessage: l10n.valEmailInvalid,
              ),
            ),
            SustinaFormField(
              controller: _phoneController,
              label: l10n.fieldPhone,
              hint: l10n.hintPhone,
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) => AppValidators.validatePhone(
                v,
                requiredMessage: l10n.valPhoneRequired,
                invalidMessage: l10n.valPhoneInvalid,
              ),
            ),
          ),
          const SizedBox(height: 16),

          rowOrStacked(
            SustinaFormField(
              controller: _jobTitleController,
              label: l10n.fieldJobTitle,
              hint: l10n.hintJobTitle,
              prefixIcon: Icons.badge_outlined,
              validator: (v) => AppValidators.validateName(
                v,
                requiredMessage: l10n.valRequiredField,
                minLengthMessage: l10n.valNameMin,
              ),
            ),
            SustinaDropdownField<String>(
              label: l10n.fieldIndustry,
              hint: l10n.hintIndustry,
              value: _selectedIndustry,
              prefixIcon: Icons.factory_outlined,
              prefixSvgPath: AppIcons.productionProcess,
              items: industries
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item.$1,
                      child: Text(
                        item.$2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => _selectedIndustry = val),
              validator: (v) => AppValidators.validateRequired(
                v,
                requiredMessage: l10n.valIndustryRequired,
              ),
            ),
          ),
          const SizedBox(height: 16),

          rowOrStacked(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.fieldPreferredDate,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    fontSize: 13.5,
                    color: colors.neutral800,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: _pickDate,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    decoration: BoxDecoration(
                      color: isDark ? colors.grey100 : colors.grey50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _preferredDate != null
                            ? colors.primary500.withValues(alpha: 0.6)
                            : colors.grey200,
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                          color: isDark
                              ? colors.primary600
                              : colors.primary500,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _preferredDate == null
                                ? l10n.hintPreferredDate
                                : _formattedDate(context),
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.font14Medium.copyWith(
                              fontSize: 13.5,
                              color: _preferredDate == null
                                  ? colors.grey500
                                  : colors.neutral900,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.edit_calendar_rounded,
                          size: 17,
                          color: colors.neutral500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SustinaDropdownField<String>(
              label: l10n.fieldPreferredTime,
              hint: l10n.timeSlotMorning,
              value: _preferredTimeSlot,
              isRequired: false,
              prefixIcon: Icons.schedule_rounded,
              items: timeSlots
                  .map(
                    (slot) => DropdownMenuItem<String>(
                      value: slot.$1,
                      child: Text(
                        slot.$2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _preferredTimeSlot = val);
              },
            ),
          ),
          const SizedBox(height: 16),

          SustinaFormField(
            controller: _notesController,
            label: l10n.fieldNotes,
            hint: l10n.hintNotes,
            prefixIcon: Icons.notes_rounded,
            isRequired: false,
            maxLines: 3,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: 24),

          SustinaPrimaryButton(
            label: l10n.demoSubmitButton,
            loadingLabel: l10n.demoSubmitting,
            isLoading: _isSubmitting,
            fullWidth: true,
            borderRadius: 14,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            onPressed: _submitDemoRequest,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final industries = SustinaFormCatalog.industries(l10n);
    final scheduleSummary = _preferredDate != null
        ? '${_formattedDate(context)} • ${_timeSlotLabel(l10n, _preferredTimeSlot)}'
        : _timeSlotLabel(l10n, _preferredTimeSlot);

    return Column(
      key: const ValueKey('demo_success'),
      mainAxisSize: MainAxisSize.min,
      children: [
        const SustinaSuccessGraphic(size: 112),
        const SizedBox(height: 12),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: colors.primary100,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: colors.primary500.withValues(alpha: 0.35),
            ),
          ),
          child: Text(
            l10n.demoSuccessBadge,
            style: AppTextStyles.font12Bold.copyWith(
              color: isDark ? colors.primary700 : colors.primary600,
            ),
          ),
        ),
        const SizedBox(height: 16),

        Text(
          l10n.demoSuccessTitle,
          textAlign: TextAlign.center,
          style: AppTextStyles.font24Bold.copyWith(
            color: colors.neutral900,
          ),
        ),
        const SizedBox(height: 10),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            l10n.demoSuccessMessage,
            textAlign: TextAlign.center,
            style: AppTextStyles.font14Regular.copyWith(
              color: colors.neutral700,
              height: 1.65,
            ),
          ),
        ),
        const SizedBox(height: 22),

        // Request Summary Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? colors.grey100 : colors.grey50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.grey200),
          ),
          child: Column(
            children: [
              _SummaryRow(
                label: l10n.demoSuccessRef,
                value: _referenceCode,
                highlight: true,
              ),
              Divider(height: 18, color: colors.grey200),
              _SummaryRow(
                label: l10n.fieldFullName,
                value: _fullNameController.text.trim(),
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: l10n.fieldCompanyName,
                value: _companyController.text.trim(),
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: l10n.fieldIndustry,
                value: SustinaFormCatalog.labelFor(
                  industries,
                  _selectedIndustry,
                ),
              ),
              const SizedBox(height: 8),
              _SummaryRow(
                label: l10n.demoSuccessSchedule,
                value: scheduleSummary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        SustinaSecondaryButton(
          label: l10n.demoBookAnother,
          icon: Icons.refresh_rounded,
          onPressed: _resetForm,
        ),
      ],
    );
  }
}

class _DemoValuePropositionPanel extends StatelessWidget {
  const _DemoValuePropositionPanel({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    final benefits = [
      (
        AppIcons.emissions,
        colors.primary500,
        l10n.demoBenefit1Title,
        l10n.demoBenefit1Desc,
      ),
      (
        AppIcons.chat,
        colors.secondary500,
        l10n.demoBenefit2Title,
        l10n.demoBenefit2Desc,
      ),
      (
        AppIcons.organization,
        colors.info700,
        l10n.demoBenefit3Title,
        l10n.demoBenefit3Desc,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < benefits.length; i++) ...[
          _BenefitTile(
            svgPath: benefits[i].$1,
            accentColor: benefits[i].$2,
            title: benefits[i].$3,
            description: benefits[i].$4,
          ),
          if (i < benefits.length - 1) const SizedBox(height: 16),
        ],
        const SizedBox(height: 22),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [
                      colors.primary100,
                      colors.primary200.withValues(alpha: 0.7),
                    ]
                  : [
                      colors.primary100.withValues(alpha: 0.75),
                      colors.secondary100.withValues(alpha: 0.65),
                    ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: colors.primary500.withValues(alpha: 0.28),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SustinaSvgIcon(
                  assetPath: AppIcons.leaf,
                  size: 19,
                  color: isDark ? colors.primary700 : colors.primary600,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  l10n.demoTrustNote,
                  style: AppTextStyles.font13Regular.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.neutral900,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BenefitTile extends StatefulWidget {
  const _BenefitTile({
    required this.svgPath,
    required this.accentColor,
    required this.title,
    required this.description,
  });

  final String svgPath;
  final Color accentColor;
  final String title;
  final String description;

  @override
  State<_BenefitTile> createState() => _BenefitTileState();
}

class _BenefitTileState extends State<_BenefitTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: _hovered
                ? widget.accentColor.withValues(alpha: 0.6)
                : colors.grey200,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: isDark ? 0.22 : 0.03),
              blurRadius: _hovered ? 18 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: widget.accentColor.withValues(
                  alpha: isDark ? 0.16 : 0.10,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: SustinaSvgIcon(
                assetPath: widget.svgPath,
                size: 22,
                color: widget.accentColor,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.font16Bold.copyWith(
                      fontSize: 15.5,
                      color: colors.neutral900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: colors.neutral700,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: AppTextStyles.font12SemiBold.copyWith(
              color: colors.neutral600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Bold.copyWith(
              fontSize: 13.5,
              color: highlight
                  ? (isDark ? colors.primary700 : colors.primary600)
                  : colors.neutral900,
            ),
          ),
        ),
      ],
    );
  }
}

