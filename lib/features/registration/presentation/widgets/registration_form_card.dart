import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_validators.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/registration/presentation/models/company_registration_data.dart';

class RegistrationFormCard extends StatefulWidget {
  const RegistrationFormCard({
    super.key,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final bool isSubmitting;
  final Future<void> Function(CompanyRegistrationData data) onSubmit;

  @override
  State<RegistrationFormCard> createState() => _RegistrationFormCardState();
}

class _RegistrationFormCardState extends State<RegistrationFormCard> {
  final _formKey = GlobalKey<FormState>();

  final _companyNameController = TextEditingController();
  final _companyEmailController = TextEditingController();
  final _contactPersonController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  String? _selectedIndustry;
  String? _selectedCompanySize;
  String? _selectedCountry;

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyEmailController.dispose();
    _contactPersonController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    widget.onSubmit(
      CompanyRegistrationData(
        referenceCode: '',
        companyName: _companyNameController.text.trim(),
        companyEmail: _companyEmailController.text.trim(),
        contactPerson: _contactPersonController.text.trim(),
        phone: _phoneController.text.trim(),
        industryId: _selectedIndustry ?? '',
        companySizeId: _selectedCompanySize ?? '',
        countryId: _selectedCountry ?? '',
        notes: _notesController.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    final industries = SustinaFormCatalog.industries(l10n);
    final sizes = SustinaFormCatalog.companySizes(l10n);
    final countries = SustinaFormCatalog.countries(l10n);

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
      padding: EdgeInsets.all(isMobile ? 20 : 30),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.grey200, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.28 : 0.05),
            blurRadius: 26,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.primary100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: SustinaSvgIcon(
                    assetPath: AppIcons.organization,
                    size: 22,
                    color: isDark ? colors.primary700 : colors.primary600,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    l10n.regFormTitle,
                    style: AppTextStyles.font20Bold.copyWith(
                      fontSize: isMobile ? 17 : 20,
                      color: colors.neutral900,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),

            // Business Model Notice: No immediate payment or package lock-in
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: isDark
                    ? colors.secondary100
                    : colors.secondary100.withValues(alpha: 0.75),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.secondary500.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 19,
                    color: isDark
                        ? colors.secondary600
                        : colors.secondary700,
                  ),
                  const SizedBox(width: 10),
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
            const SizedBox(height: 22),

            twoColOrStack(
              SustinaFormField(
                controller: _companyNameController,
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
              SustinaFormField(
                controller: _companyEmailController,
                label: l10n.fieldCompanyEmail,
                hint: l10n.hintCompanyEmail,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (v) => AppValidators.validateEmail(
                  v,
                  requiredMessage: l10n.valEmailRequired,
                  invalidMessage: l10n.valEmailInvalid,
                ),
              ),
            ),
            const SizedBox(height: 16),

            twoColOrStack(
              SustinaFormField(
                controller: _contactPersonController,
                label: l10n.fieldContactPerson,
                hint: l10n.hintContactPerson,
                prefixIcon: Icons.person_outline_rounded,
                validator: (v) => AppValidators.validateName(
                  v,
                  requiredMessage: l10n.valRequiredField,
                  minLengthMessage: l10n.valNameMin,
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

            twoColOrStack(
              SustinaDropdownField<String>(
                label: l10n.fieldIndustry,
                hint: l10n.hintIndustry,
                value: _selectedIndustry,
                prefixIcon: Icons.factory_outlined,
                prefixSvgPath: AppIcons.productionProcess,
                items: industries
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.$1,
                        child: Text(e.$2, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedIndustry = v),
                validator: (v) => AppValidators.validateRequired(
                  v,
                  requiredMessage: l10n.valIndustryRequired,
                ),
              ),
              SustinaDropdownField<String>(
                label: l10n.fieldCompanySize,
                hint: l10n.hintCompanySize,
                value: _selectedCompanySize,
                prefixIcon: Icons.groups_outlined,
                items: sizes
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.$1,
                        child: Text(e.$2, overflow: TextOverflow.ellipsis),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => _selectedCompanySize = v),
                validator: (v) => AppValidators.validateRequired(
                  v,
                  requiredMessage: l10n.valCompanySizeRequired,
                ),
              ),
            ),
            const SizedBox(height: 16),

            SustinaDropdownField<String>(
              label: l10n.fieldCountry,
              hint: l10n.hintCountry,
              value: _selectedCountry,
              prefixIcon: Icons.public_rounded,
              items: countries
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e.$1,
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
            const SizedBox(height: 16),

            SustinaFormField(
              controller: _notesController,
              label: l10n.fieldRegNotes,
              hint: l10n.hintRegNotes,
              prefixIcon: Icons.notes_rounded,
              isRequired: false,
              maxLines: 3,
              textInputAction: TextInputAction.newline,
            ),
            const SizedBox(height: 24),

            SustinaPrimaryButton(
              label: l10n.regSubmitButton,
              loadingLabel: l10n.regSubmitting,
              isLoading: widget.isSubmitting,
              fullWidth: true,
              borderRadius: 14,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              onPressed: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }
}

