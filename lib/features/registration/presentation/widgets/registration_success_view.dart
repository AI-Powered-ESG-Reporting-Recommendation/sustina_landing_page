import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/registration/presentation/models/company_registration_data.dart';

class RegistrationSuccessView extends StatelessWidget {
  const RegistrationSuccessView({
    super.key,
    required this.data,
    required this.onReset,
  });

  final CompanyRegistrationData data;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isMobile = context.isMobile;

    final industries = SustinaFormCatalog.industries(l10n);
    final sizes = SustinaFormCatalog.companySizes(l10n);
    final countries = SustinaFormCatalog.countries(l10n);

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 32),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.primary500.withValues(alpha: 0.55),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.30 : 0.06),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SustinaSuccessGraphic(size: 118),
          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: colors.primary100,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: colors.primary500.withValues(alpha: 0.4),
              ),
            ),
            child: Text(
              l10n.regSuccessBadge,
              textAlign: TextAlign.center,
              style: AppTextStyles.font12Bold.copyWith(
                color: isDark ? colors.primary700 : colors.primary600,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            l10n.regSuccessTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.font24Bold.copyWith(
              fontSize: isMobile ? 20 : 25,
              color: colors.neutral900,
            ),
          ),
          const SizedBox(height: 12),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              l10n.regSuccessDesc,
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.copyWith(
                color: colors.neutral700,
                height: 1.65,
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Next Steps: Admin Follow-Up & Package Consultation Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        colors.secondary100,
                        colors.primary100.withValues(alpha: 0.8),
                      ]
                    : [
                        colors.secondary100,
                        colors.primary100.withValues(alpha: 0.55),
                      ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colors.secondary500.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!isMobile) ...[
                  SvgPicture.asset(
                    AppIcons.pending,
                    width: 64,
                    height: 64,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.regSuccessNextTitle,
                        style: AppTextStyles.font16Bold.copyWith(
                          color: colors.neutral900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.regSuccessNextBody,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: colors.neutral800,
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Submitted Company Profile Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isDark ? colors.grey100 : colors.grey50,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        l10n.regSummaryTitle,
                        style: AppTextStyles.font14Bold.copyWith(
                          color: colors.neutral900,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primary500.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        data.referenceCode,
                        style: AppTextStyles.font12Bold.copyWith(
                          color: isDark ? colors.primary700 : colors.primary600,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 22, color: colors.grey200),
                _ProfileLine(
                  label: l10n.fieldCompanyName,
                  value: data.companyName,
                ),
                const SizedBox(height: 8),
                _ProfileLine(
                  label: l10n.fieldCompanyEmail,
                  value: data.companyEmail,
                ),
                const SizedBox(height: 8),
                _ProfileLine(
                  label: l10n.fieldContactPerson,
                  value: data.contactPerson,
                ),
                const SizedBox(height: 8),
                _ProfileLine(
                  label: l10n.fieldPhone,
                  value: data.phone,
                ),
                const SizedBox(height: 8),
                _ProfileLine(
                  label: l10n.fieldIndustry,
                  value: SustinaFormCatalog.labelFor(industries, data.industryId),
                ),
                const SizedBox(height: 8),
                _ProfileLine(
                  label: l10n.fieldCompanySize,
                  value: SustinaFormCatalog.labelFor(sizes, data.companySizeId),
                ),
                const SizedBox(height: 8),
                _ProfileLine(
                  label: l10n.fieldCountry,
                  value: SustinaFormCatalog.labelFor(countries, data.countryId),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),

          Wrap(
            spacing: 14,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              SustinaPrimaryButton(
                label: l10n.regBackToLanding,
                onPressed: () => context.go(Routes.landing),
              ),
              SustinaSecondaryButton(
                label: l10n.regRegisterAnother,
                icon: Icons.add_business_outlined,
                onPressed: onReset,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileLine extends StatelessWidget {
  const _ProfileLine({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
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
            style: AppTextStyles.font13Regular.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.neutral900,
            ),
          ),
        ),
      ],
    );
  }
}

