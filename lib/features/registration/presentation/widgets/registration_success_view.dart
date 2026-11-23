import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/routing/routes.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:suatina_web_project/features/registration/data/models/registration_response_model.dart';

class RegistrationSuccessView extends StatelessWidget {
  const RegistrationSuccessView({
    super.key,
    required this.response,
    required this.onReset,
  });

  final RegistrationResponseModel response;
  final VoidCallback onReset;

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) {
      return DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
    }
    try {
      final dt = DateTime.parse(rawDate);
      return DateFormat('yyyy-MM-dd HH:mm').format(dt.toLocal());
    } catch (_) {
      return rawDate;
    }
  }

  void _copyReferenceCode(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    final isArabic = context.isArabic;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isArabic
              ? 'تم نسخ الكود المرجعي بنجاح: $code'
              : 'Reference code copied to clipboard: $code',
          style: AppTextStyles.font13Regular.copyWith(color: Colors.white),
        ),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF14532D),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDark = context.isDarkMode;
    final isArabic = context.isArabic;
    final isMobile = context.isMobile;

    final reg = response.registration;
    final org = response.organization;
    final admin = response.admin;
    final doc = response.document;

    final refCode = reg?.referenceCode ?? 'REG-PENDING';
    final status = reg?.status ?? 'PENDING';
    final submissionDate = _formatDate(reg?.submittedAt);

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 36),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colors.primary500.withValues(alpha: 0.6),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary500.withValues(alpha: isDark ? 0.2 : 0.08),
            blurRadius: 36,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Celebratory Graphic
          const SustinaSuccessGraphic(size: 110),
          const SizedBox(height: 16),

          // Stage Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? colors.primary100 : colors.primary100,
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
            response.message != null && response.message!.isNotEmpty
                ? response.message!
                : l10n.regSuccessTitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.font24Bold.copyWith(
              fontSize: isMobile ? 20 : 26,
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
          const SizedBox(height: 28),

          // Reference Code Action Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        colors.primary100.withValues(alpha: 0.5),
                        colors.secondary100.withValues(alpha: 0.3),
                      ]
                    : [
                        colors.primary100.withValues(alpha: 0.6),
                        colors.secondary100.withValues(alpha: 0.35),
                      ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: colors.primary500.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.white,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.qr_code_rounded,
                    size: 22,
                    color: isDark ? colors.primary700 : colors.primary600,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isArabic
                            ? 'الكود المرجعي لطلب التسجيل'
                            : 'Official Registration Reference',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: colors.neutral600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      SelectableText(
                        refCode,
                        style: AppTextStyles.font20Bold.copyWith(
                          fontFamily: 'monospace',
                          letterSpacing: 1.2,
                          color: colors.neutral900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.warning500.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colors.warning500.withValues(alpha: 0.45),
                    ),
                  ),
                  child: Text(
                    status,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: colors.warning500,
                      fontSize: 11,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // Copy Button
                IconButton(
                  tooltip: isArabic
                      ? 'نسخ الكود المرجعي'
                      : 'Copy Reference Code',
                  icon: Icon(
                    Icons.copy_rounded,
                    size: 18,
                    color: isDark ? colors.primary700 : colors.primary600,
                  ),
                  onPressed: () => _copyReferenceCode(context, refCode),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Next Steps Roadmap
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? colors.grey100 : colors.grey50,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.timeline_rounded,
                      size: 20,
                      color: isDark ? colors.primary700 : colors.primary600,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        l10n.regSuccessNextTitle,
                        style: AppTextStyles.font16Bold.copyWith(
                          color: colors.neutral900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _RoadmapStep(
                  stepNumber: '1',
                  title: isArabic
                      ? 'مراجعة الوثائق والتحقق المؤسسي (24-48 ساعة)'
                      : 'Compliance & Verification Review (24–48 Hours)',
                  desc: isArabic
                      ? 'يقوم فريق الامتثال بمراجعة وثائق المنشأة والتأكد من بيانات السجل التجاري.'
                      : 'Our administration team verifies corporate legal credentials and uploaded documents.',
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _RoadmapStep(
                  stepNumber: '2',
                  title: isArabic
                      ? 'جلسة استشارية وتحديد باقة الاشتراك المناسبة'
                      : 'Consultative Assessment & Package Recommendation',
                  desc: isArabic
                      ? 'يتواصل معك مستشار الاستدامة لتقييم نطاق الإفصاح وتحديد الباقة دون أي إلزام فوري.'
                      : 'Our ESG advisors collaborate with you to evaluate reporting scope and tailor subscription options.',
                  isDark: isDark,
                ),
                const SizedBox(height: 10),
                _RoadmapStep(
                  stepNumber: '3',
                  title: isArabic
                      ? 'تفعيل مساحة العمل المؤسسية وإصدار صلاحيات الدخول'
                      : 'Workspace Activation & Platform Access',
                  desc: isArabic
                      ? 'عقب الاتفاق، يتم تفعيل بوابة الشركة وإرسال بيانات الاعتماد لحساب المدير.'
                      : 'Dedicated tenant provisioned with role-based access for your administration team.',
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Submitted Profile Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? colors.grey100 : colors.grey50,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: colors.grey200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.regSummaryTitle,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: colors.neutral900,
                  ),
                ),
                Divider(height: 20, color: colors.grey200),

                if (org?.legalName != null && org!.legalName!.isNotEmpty) ...[
                  _ProfileLine(
                    label: l10n.organizationLabel,
                    value: org.legalName!,
                  ),
                  const SizedBox(height: 8),
                ],

                if (org?.hqCountry != null && org!.hqCountry!.isNotEmpty) ...[
                  _ProfileLine(
                    label: l10n.fieldHqCountry,
                    value: org.hqCountry!,
                  ),
                  const SizedBox(height: 8),
                ],

                if (org?.firstReportingYear != null) ...[
                  _ProfileLine(
                    label: l10n.reportingYearLabel,
                    value: org!.firstReportingYear.toString(),
                  ),
                  const SizedBox(height: 8),
                ],

                if (admin?.email != null && admin!.email!.isNotEmpty) ...[
                  _ProfileLine(label: l10n.adminLabel, value: admin.email!),
                  const SizedBox(height: 8),
                ],

                if (doc?.originalName != null &&
                    doc!.originalName!.isNotEmpty) ...[
                  _ProfileLine(
                    label: l10n.documentLabel,
                    value: doc.originalName!,
                  ),
                  const SizedBox(height: 8),
                ],

                _ProfileLine(
                  label: l10n.submissionDateLabel,
                  value: submissionDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Action Buttons
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 12,
            children: [
              SustinaPrimaryButton(
                label: l10n.regBackToLanding,
                icon: Icons.home_rounded,
                borderRadius: 14,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 14,
                ),
                onPressed: () => context.go(Routes.landing),
              ),
              OutlinedButton.icon(
                onPressed: onReset,
                icon: const Icon(Icons.refresh_rounded, size: 16),
                label: Text(l10n.regRegisterAnother),
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.neutral900,
                  side: BorderSide(color: colors.grey300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  textStyle: AppTextStyles.font12Bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoadmapStep extends StatelessWidget {
  const _RoadmapStep({
    required this.stepNumber,
    required this.title,
    required this.desc,
    required this.isDark,
  });

  final String stepNumber;
  final String title;
  final String desc;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: isDark ? colors.primary200 : colors.primary100,
            shape: BoxShape.circle,
            border: Border.all(
              color: colors.primary500.withValues(alpha: 0.35),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            stepNumber,
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
              Text(
                title,
                style: AppTextStyles.font12Bold.copyWith(
                  color: colors.neutral900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: AppTextStyles.font12Regular.copyWith(
                  color: colors.neutral700,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            label,
            style: AppTextStyles.font12Regular.copyWith(
              color: colors.neutral600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.font12Bold.copyWith(color: colors.neutral900),
          ),
        ),
      ],
    );
  }
}
