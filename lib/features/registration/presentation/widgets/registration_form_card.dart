import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suatina_web_project/core/helpers/app_validators.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/registration/logic/registration_cubit.dart';
import 'package:suatina_web_project/features/registration/logic/registration_state.dart';

class RegistrationFormCard extends StatefulWidget {
  const RegistrationFormCard({super.key});

  @override
  State<RegistrationFormCard> createState() => _RegistrationFormCardState();
}

class _RegistrationFormCardState extends State<RegistrationFormCard> {
  final _formKey = GlobalKey<FormState>();

  final _legalNameController = TextEditingController();
  final _hqCountryController = TextEditingController();
  final _firstReportingYearController = TextEditingController(text: '2026');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedCountry;
  String? _selectedYear = '2026';
  bool _submittedOnce = false;
  bool _isDropZoneHovered = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
    _legalNameController.dispose();
    _hqCountryController.dispose();
    _firstReportingYearController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickVerificationDocument() async {
    try {
      final files = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (files.isNotEmpty) {
        final file = files.first;
        final bytes = await file.readAsBytes();
        final size = await file.length() ?? bytes.lengthInBytes;
        if (!mounted) return;
        context.read<RegistrationCubit>().setDocument(
              bytes: bytes,
              name: file.name,
              size: size,
            );
      }
    } catch (_) {
      // Graceful error handling
    }
  }

  void _handleSubmit() {
    setState(() => _submittedOnce = true);

    final formValid = _formKey.currentState?.validate() ?? false;
    final cubit = context.read<RegistrationCubit>();
    final state = cubit.state;

    if (!formValid) return;
    if (!state.isSubIndustrySelected) return;
    if (!state.isDocumentSelected) return;
    if (!state.termsAccepted) return;

    cubit.submitRegistration(
      legalName: _legalNameController.text.trim(),
      hqCountry: _selectedCountry ?? _hqCountryController.text.trim(),
      firstReportingYear:
          _selectedYear ?? _firstReportingYearController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isArabic = context.isArabic;
    final isMobile = context.isMobile;

    final countries = SustinaFormCatalog.countries(l10n);
    final availableYears = [
      '2024',
      '2025',
      '2026',
      '2027',
      '2028',
      '2029',
      '2030'
    ];

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();

        Widget twoColOrStack(Widget first, Widget second) {
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

        return Container(
          padding: EdgeInsets.all(isMobile ? 20 : 36),
          decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: colors.grey200, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: isDark ? 0.32 : 0.05),
                blurRadius: 32,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Branded Form Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.primary100,
                            colors.secondary100.withValues(alpha: 0.6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: colors.primary500.withValues(alpha: 0.25),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SustinaSvgIcon(
                        assetPath: AppIcons.organization,
                        size: 24,
                        color: isDark ? colors.primary700 : colors.primary600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.regFormTitle,
                            style: AppTextStyles.font20Bold.copyWith(
                              fontSize: isMobile ? 18 : 22,
                              color: colors.neutral900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.regTimelineSubtitle,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: colors.neutral600,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Consultative Notice Callout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              colors.secondary100.withValues(alpha: 0.4),
                              colors.primary100.withValues(alpha: 0.25),
                            ]
                          : [
                              colors.secondary100,
                              colors.primary100.withValues(alpha: 0.5),
                            ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors.secondary500.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: isDark
                            ? colors.secondary600
                            : colors.secondary700,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l10n.regFormNotice,
                          style: AppTextStyles.font13Regular.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colors.neutral900,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // ==========================================
                // SECTION 1: Organization Identification
                // ==========================================
                _SectionHeader(
                  number: '01',
                  title: l10n.organizationLabel,
                  subtitle: isArabic
                      ? 'البيانات الرسمية وهوية المنشأة القانونية'
                      : 'Legal identification & headquarters information',
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                twoColOrStack(
                  SustinaFormField(
                    controller: _legalNameController,
                    label: l10n.fieldLegalName,
                    hint: l10n.hintLegalName,
                    prefixIcon: Icons.business_rounded,
                    prefixSvgPath: AppIcons.organization,
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return l10n.valRequiredField;
                      }
                      if (v.trim().length < 2) {
                        return l10n.valLegalNameMin;
                      }
                      return null;
                    },
                  ),
                  SustinaDropdownField<String>(
                    label: l10n.fieldHqCountry,
                    hint: l10n.hintHqCountry,
                    value: _selectedCountry,
                    prefixIcon: Icons.public_rounded,
                    items: countries
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e.$2,
                            child: Text(e.$2, overflow: TextOverflow.ellipsis),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedCountry = v),
                    validator: (v) => AppValidators.validateRequired(
                      v,
                      requiredMessage: l10n.valCountryRequired,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // First Reporting Year
                SustinaDropdownField<String>(
                  label: l10n.fieldFirstReportingYear,
                  hint: l10n.hintFirstReportingYear,
                  value: _selectedYear,
                  prefixIcon: Icons.calendar_today_rounded,
                  items: availableYears
                      .map(
                        (y) => DropdownMenuItem<String>(
                          value: y,
                          child: Text(y),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedYear = v),
                  validator: (v) => AppValidators.validateRequired(
                    v,
                    requiredMessage: l10n.valRequiredField,
                  ),
                ),
                const SizedBox(height: 32),

                // ==========================================
                // SECTION 2: Cascading Industry Classification
                // ==========================================
                _SectionHeader(
                  number: '02',
                  title: l10n.classificationLabel,
                  subtitle: isArabic
                      ? 'تصنيف ثلاثي المستويات لتحديد معايير الاستدامة المناسبة'
                      : '3-tier classification driving tailored ESG framework metrics',
                  isDark: isDark,
                  badge: '3-Level Hierarchy',
                ),
                const SizedBox(height: 16),

                // Level 1: Sector Dropdown
                _buildSectorDropdown(context, state, cubit, l10n),
                const SizedBox(height: 16),

                // Level 2: Industry Dropdown (Depends on Sector)
                _buildIndustryDropdown(context, state, cubit, l10n),
                const SizedBox(height: 16),

                // Level 3: Sub-Industry Dropdown (Depends on Industry)
                _buildSubIndustryDropdown(context, state, cubit, l10n),
                const SizedBox(height: 32),

                // ==========================================
                // SECTION 3: Official Verification Document (PDF)
                // ==========================================
                _SectionHeader(
                  number: '03',
                  title: l10n.fieldVerificationDoc,
                  subtitle: isArabic
                      ? 'إرفاق السجل التجاري أو خطاب التفويض بصيغة PDF'
                      : 'Commercial registration or authorization certificate (PDF only)',
                  isDark: isDark,
                  badge: isArabic ? 'مطلوب للتحقق' : 'Mandatory',
                ),
                const SizedBox(height: 16),
                _buildDocumentUploadCard(context, state, cubit, l10n),
                const SizedBox(height: 32),

                // ==========================================
                // SECTION 4: Administrator Account
                // ==========================================
                _SectionHeader(
                  number: '04',
                  title: l10n.adminLabel,
                  subtitle: isArabic
                      ? 'بيانات الدخول الأولية لحساب مدير المنشأة'
                      : 'Initial credentials for enterprise workspace administration',
                  isDark: isDark,
                ),
                const SizedBox(height: 16),

                SustinaFormField(
                  controller: _emailController,
                  label: l10n.fieldAdminEmail,
                  hint: l10n.hintAdminEmail,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => AppValidators.validateEmail(
                    v,
                    requiredMessage: l10n.valEmailRequired,
                    invalidMessage: l10n.valEmailInvalid,
                  ),
                ),
                const SizedBox(height: 16),

                twoColOrStack(
                  SustinaFormField(
                    controller: _passwordController,
                    label: l10n.fieldPassword,
                    hint: l10n.hintPassword,
                    prefixIcon: Icons.lock_outline_rounded,
                    obscureText: !state.isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: colors.grey500,
                      ),
                      onPressed: cubit.togglePasswordVisibility,
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return l10n.valRequiredField;
                      }
                      if (v.length < 12) {
                        return l10n.valPasswordMin;
                      }
                      final hasUpper = v.contains(RegExp(r'[A-Z]'));
                      final hasLower = v.contains(RegExp(r'[a-z]'));
                      final hasDigit = v.contains(RegExp(r'[0-9]'));
                      final hasSpecial = v.contains(RegExp(r'[@$!%*?&]'));
                      if (!hasUpper || !hasLower || !hasDigit || !hasSpecial) {
                        return l10n.valPasswordComplexity;
                      }
                      return null;
                    },
                  ),
                  SustinaFormField(
                    controller: _confirmPasswordController,
                    label: l10n.fieldConfirmPassword,
                    hint: l10n.hintConfirmPassword,
                    prefixIcon: Icons.lock_clock_outlined,
                    obscureText: !state.isConfirmPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isConfirmPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: colors.grey500,
                      ),
                      onPressed: cubit.toggleConfirmPasswordVisibility,
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return l10n.valRequiredField;
                      }
                      if (v != _passwordController.text) {
                        return l10n.valPasswordMatch;
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),

                // Dynamic Live Password Criteria Indicator Chips
                _PasswordCriteriaRow(
                  password: _passwordController.text,
                  isDark: isDark,
                  isArabic: isArabic,
                ),
                const SizedBox(height: 24),

                // ==========================================
                // SECTION 5: Terms & Conditions Checkbox
                // ==========================================
                _buildTermsCheckbox(context, state, cubit, l10n),
                const SizedBox(height: 20),

                // Server Error Alert Banner (if any)
                if (state.submitError != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.error700.withValues(
                        alpha: isDark ? 0.22 : 0.08,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colors.error700.withValues(alpha: 0.45),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          size: 22,
                          color: colors.error700,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            state.submitError!,
                            style: AppTextStyles.font13Regular.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colors.error700,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Submit Primary Action Button
                SustinaPrimaryButton(
                  label: l10n.regSubmitButton,
                  loadingLabel: l10n.regSubmitting,
                  isLoading: state.isSubmitting,
                  fullWidth: true,
                  borderRadius: 16,
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 28,
                  ),
                  onPressed: state.isSubmitting ? null : _handleSubmit,
                ),
                const SizedBox(height: 14),

                // Security Reassurance Note
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock_rounded,
                      size: 14,
                      color: isDark ? colors.primary700 : colors.primary600,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isArabic
                          ? 'اتصال آمن ومشفّر 256-bit • لا توجد رسوم أو مدفوعات فورية'
                          : '256-Bit SSL Encrypted • Zero Upfront Billing Required',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.neutral600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectorDropdown(
    BuildContext context,
    RegistrationState state,
    RegistrationCubit cubit,
    AppLocalizations l10n,
  ) {
    final colors = context.customAppColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.fieldSector,
              style: AppTextStyles.font14Bold.copyWith(
                color: colors.neutral900,
              ),
            ),
            if (state.isSectorsLoading)
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.primary500,
                ),
              )
            else if (state.sectorsError != null)
              TextButton.icon(
                onPressed: cubit.loadSectors,
                icon: const Icon(Icons.refresh_rounded, size: 14),
                label: Text(l10n.retryLoading, style: AppTextStyles.font12Bold),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: state.selectedSectorId,
          items: state.sectors
              .map(
                (s) => DropdownMenuItem<String>(
                  value: s.id,
                  child: Text(s.name, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: cubit.selectSector,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return l10n.valRequiredField;
            }
            return null;
          },
          isExpanded: true,
          dropdownColor: colors.white,
          decoration: _sustinaDropdownDecoration(
            context,
            hint: state.isSectorsLoading
                ? l10n.loadingSectors
                : l10n.hintSector,
            prefixIcon: Icons.category_outlined,
          ),
        ),
      ],
    );
  }

  Widget _buildIndustryDropdown(
    BuildContext context,
    RegistrationState state,
    RegistrationCubit cubit,
    AppLocalizations l10n,
  ) {
    final colors = context.customAppColors;
    final isEnabled = state.isSectorSelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.fieldIndustry,
              style: AppTextStyles.font14Bold.copyWith(
                color: isEnabled ? colors.neutral900 : colors.grey500,
              ),
            ),
            if (state.isIndustriesLoading)
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.primary500,
                ),
              )
            else if (state.industriesError != null)
              TextButton.icon(
                onPressed: () => cubit.selectSector(state.selectedSectorId),
                icon: const Icon(Icons.refresh_rounded, size: 14),
                label: Text(l10n.retryLoading, style: AppTextStyles.font12Bold),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: state.selectedIndustryId,
          items: state.industries
              .map(
                (i) => DropdownMenuItem<String>(
                  value: i.id,
                  child: Text(i.name, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: isEnabled ? cubit.selectIndustry : null,
          validator: (v) {
            if (isEnabled && (v == null || v.isEmpty)) {
              return l10n.valRequiredField;
            }
            return null;
          },
          isExpanded: true,
          dropdownColor: colors.white,
          decoration: _sustinaDropdownDecoration(
            context,
            hint: !isEnabled
                ? l10n.selectSectorFirst
                : (state.isIndustriesLoading
                    ? l10n.loadingIndustries
                    : l10n.hintIndustry),
            prefixIcon: Icons.factory_outlined,
            prefixSvgPath: AppIcons.productionProcess,
            enabled: isEnabled,
          ),
        ),
      ],
    );
  }

  Widget _buildSubIndustryDropdown(
    BuildContext context,
    RegistrationState state,
    RegistrationCubit cubit,
    AppLocalizations l10n,
  ) {
    final colors = context.customAppColors;
    final isEnabled = state.isIndustrySelected;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.fieldSubIndustry,
              style: AppTextStyles.font14Bold.copyWith(
                color: isEnabled ? colors.neutral900 : colors.grey500,
              ),
            ),
            if (state.isSubIndustriesLoading)
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.primary500,
                ),
              )
            else if (state.subIndustriesError != null)
              TextButton.icon(
                onPressed: () =>
                    cubit.selectIndustry(state.selectedIndustryId),
                icon: const Icon(Icons.refresh_rounded, size: 14),
                label: Text(l10n.retryLoading, style: AppTextStyles.font12Bold),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: state.selectedSubIndustryId,
          items: state.subIndustries
              .map(
                (si) => DropdownMenuItem<String>(
                  value: si.id,
                  child: Text(si.name, overflow: TextOverflow.ellipsis),
                ),
              )
              .toList(),
          onChanged: isEnabled ? cubit.selectSubIndustry : null,
          validator: (v) {
            if (isEnabled && (v == null || v.isEmpty)) {
              return l10n.valRequiredField;
            }
            return null;
          },
          isExpanded: true,
          dropdownColor: colors.white,
          decoration: _sustinaDropdownDecoration(
            context,
            hint: !isEnabled
                ? l10n.selectIndustryFirst
                : (state.isSubIndustriesLoading
                    ? l10n.loadingSubIndustries
                    : l10n.hintSubIndustry),
            prefixIcon: Icons.account_tree_outlined,
            enabled: isEnabled,
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadCard(
    BuildContext context,
    RegistrationState state,
    RegistrationCubit cubit,
    AppLocalizations l10n,
  ) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final hasDoc = state.isDocumentSelected;
    final hasError = _submittedOnce && !hasDoc;

    if (hasDoc) {
      return Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? colors.grey100 : colors.grey50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: colors.primary500.withValues(alpha: 0.6),
            width: 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.primary500.withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.primary100,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.primary500.withValues(alpha: 0.3),
                ),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.picture_as_pdf_rounded,
                size: 26,
                color: isDark ? colors.primary700 : colors.primary600,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          state.documentName ?? 'verification_document.pdf',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font14Bold.copyWith(
                            color: colors.neutral900,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.check_circle_rounded,
                        size: 16,
                        color: colors.primary500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _formatFileSize(state.documentSize ?? 0),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: colors.neutral600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            OutlinedButton(
              onPressed: _pickVerificationDocument,
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark ? colors.primary700 : colors.primary600,
                side: BorderSide(
                  color: colors.primary500.withValues(alpha: 0.5),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                l10n.btnChangeDoc,
                style: AppTextStyles.font12Bold,
              ),
            ),
            const SizedBox(width: 6),
            IconButton(
              icon: Icon(
                Icons.delete_outline_rounded,
                size: 20,
                color: colors.neutral600,
              ),
              tooltip: l10n.btnRemoveDoc,
              onPressed: cubit.clearDocument,
            ),
          ],
        ),
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isDropZoneHovered = true),
      onExit: (_) => setState(() => _isDropZoneHovered = false),
      child: GestureDetector(
        onTap: _pickVerificationDocument,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: _isDropZoneHovered
                ? (isDark
                    ? colors.primary100.withValues(alpha: 0.3)
                    : colors.primary100.withValues(alpha: 0.4))
                : (isDark ? colors.grey100 : colors.grey50),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: hasError
                  ? colors.error700
                  : (_isDropZoneHovered
                      ? colors.primary500
                      : colors.grey300),
              width: hasError || _isDropZoneHovered ? 1.6 : 1.2,
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: hasError
                      ? colors.error700.withValues(alpha: 0.12)
                      : colors.primary100,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.cloud_upload_outlined,
                  size: 28,
                  color: hasError
                      ? colors.error700
                      : (isDark ? colors.primary700 : colors.primary600),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l10n.btnUploadDoc,
                style: AppTextStyles.font14Bold.copyWith(
                  color: colors.neutral900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.fieldVerificationDocHint,
                textAlign: TextAlign.center,
                style: AppTextStyles.font12Regular.copyWith(
                  color: hasError ? colors.error700 : colors.neutral600,
                ),
              ),
              if (hasError) ...[
                const SizedBox(height: 8),
                Text(
                  l10n.docRequiredError,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: colors.error700,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsCheckbox(
    BuildContext context,
    RegistrationState state,
    RegistrationCubit cubit,
    AppLocalizations l10n,
  ) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final hasError = _submittedOnce && !state.termsAccepted;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: hasError
            ? colors.error700.withValues(alpha: isDark ? 0.15 : 0.05)
            : (isDark ? colors.grey100 : colors.grey50),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasError
              ? colors.error700.withValues(alpha: 0.5)
              : colors.grey200,
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: state.termsAccepted,
            activeColor: isDark ? colors.primary700 : colors.primary600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: (val) => cubit.setTermsAccepted(val ?? false),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () => cubit.setTermsAccepted(!state.termsAccepted),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.termsCheckboxLabel,
                    style: AppTextStyles.font13Regular.copyWith(
                      color: colors.neutral800,
                      height: 1.5,
                    ),
                  ),
                  if (hasError) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.termsRequiredError,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: colors.error700,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _sustinaDropdownDecoration(
    BuildContext context, {
    required String hint,
    required IconData prefixIcon,
    String? prefixSvgPath,
    bool enabled = true,
  }) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;
    final iconColor = enabled
        ? (isDark ? colors.primary600 : colors.primary500)
        : colors.grey400;

    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.font14Regular.copyWith(
        fontSize: 13.5,
        color: enabled ? colors.grey500 : colors.grey400,
      ),
      filled: true,
      fillColor: enabled
          ? (isDark ? colors.grey100 : colors.grey50)
          : (isDark ? colors.grey50 : colors.grey100),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      prefixIcon: Padding(
        padding: const EdgeInsetsDirectional.only(start: 12, end: 10),
        child: prefixSvgPath != null
            ? SustinaSvgIcon(
                assetPath: prefixSvgPath,
                size: 18,
                color: iconColor,
                fallbackIcon: prefixIcon,
              )
            : Icon(prefixIcon, size: 19, color: iconColor),
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 42, minHeight: 24),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.grey200, width: 1.2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: enabled ? colors.grey200 : colors.grey100,
          width: 1.2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.primary500, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.error700, width: 1.3),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colors.error700, width: 1.6),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.isDark,
    this.badge,
  });

  final String number;
  final String title;
  final String subtitle;
  final bool isDark;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isDark ? colors.primary200 : colors.primary100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: colors.primary500.withValues(alpha: 0.35),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: AppTextStyles.font12Bold.copyWith(
              color: isDark ? colors.primary800 : colors.primary600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      title,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        badge!,
                        style: AppTextStyles.font12Bold.copyWith(
                          fontSize: 11,
                          color: isDark
                              ? colors.primary700
                              : colors.primary600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.neutral600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PasswordCriteriaRow extends StatelessWidget {
  const _PasswordCriteriaRow({
    required this.password,
    required this.isDark,
    required this.isArabic,
  });

  final String password;
  final bool isDark;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final hasLength = password.length >= 12;
    final hasUpper = password.contains(RegExp(r'[A-Z]'));
    final hasLower = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecial = password.contains(RegExp(r'[@$!%*?&]'));

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _CriteriaChip(
          label: isArabic ? '12+ حرفاً' : '12+ chars',
          met: hasLength,
          isDark: isDark,
        ),
        _CriteriaChip(
          label: isArabic ? 'حرف كبير (A-Z)' : 'Uppercase (A-Z)',
          met: hasUpper,
          isDark: isDark,
        ),
        _CriteriaChip(
          label: isArabic ? 'حرف صغير (a-z)' : 'Lowercase (a-z)',
          met: hasLower,
          isDark: isDark,
        ),
        _CriteriaChip(
          label: isArabic ? 'رقم (0-9)' : 'Number (0-9)',
          met: hasDigit,
          isDark: isDark,
        ),
        _CriteriaChip(
          label: isArabic ? r'رمز خاص (@$!%*?&)' : r'Symbol (@$!%*?&)',
          met: hasSpecial,
          isDark: isDark,
        ),
      ],
    );
  }
}

class _CriteriaChip extends StatelessWidget {
  const _CriteriaChip({
    required this.label,
    required this.met,
    required this.isDark,
  });

  final String label;
  final bool met;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: met
            ? (isDark ? colors.primary200 : colors.primary100)
            : (isDark ? colors.grey100 : colors.grey50),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: met ? colors.primary500 : colors.grey200,
          width: 1.1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
            size: 13,
            color: met
                ? (isDark ? colors.primary800 : colors.primary600)
                : colors.grey400,
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppTextStyles.font12Bold.copyWith(
              fontSize: 11,
              color: met
                  ? (isDark ? colors.primary800 : colors.primary700)
                  : colors.neutral600,
            ),
          ),
        ],
      ),
    );
  }
}
