import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/helpers/app_reveal_animation.dart';
import 'package:suatina_web_project/core/helpers/app_validators.dart';
import 'package:suatina_web_project/core/localization/app_localizations.dart';
import 'package:suatina_web_project/core/responsive/responsive.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';
import 'package:suatina_web_project/core/utils/app_icons.dart';
import 'package:suatina_web_project/core/widgets/sustina_social_links.dart';
import 'package:suatina_web_project/core/widgets/sustina_ui_kit.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingContactSection extends StatefulWidget {
  const LandingContactSection({
    super.key,
    this.onBookDemoPressed,
  });

  final VoidCallback? onBookDemoPressed;

  @override
  State<LandingContactSection> createState() => _LandingContactSectionState();
}

class _LandingContactSectionState extends State<LandingContactSection> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  bool _isSubmitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
      _isSubmitted = true;
    });
  }

  void _resetForm() {
    setState(() {
      _isSubmitted = false;
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final l10n = context.l10n;
    final isDesktop = context.isDesktopOrLarger;

    return Container(
      width: double.infinity,
      color: colors.background,
      child: AdaptiveContentContainer(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsivePadding.pageHorizontal(context),
          vertical: context.responsiveValue<double>(
            mobile: 48,
            tablet: 72,
            desktop: 88,
          ),
        ),
        child: Column(
          children: [
            AppRevealAnimation(
              child: SustinaSectionHeader(
                category: l10n.contactBadge,
                title: l10n.contactTitle,
                subtitle: l10n.contactSubtitle,
                badgeSvgPath: AppIcons.chat,
                useSecondaryAccent: true,
              ),
            ),
            SizedBox(
              height: context.responsiveValue<double>(
                mobile: 28,
                tablet: 40,
                desktop: 48,
              ),
            ),

            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: _buildInfoCard(context, l10n),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    flex: 7,
                    child: _buildFormOrSuccess(context, l10n),
                  ),
                ],
              )
            else
              Column(
                children: [
                  _buildInfoCard(context, l10n),
                  const SizedBox(height: 24),
                  _buildFormOrSuccess(context, l10n),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, AppLocalizations l10n) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isDark ? colors.grey100 : colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.grey200, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: isDark ? 0.28 : 0.05),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Icon(
                  Icons.headset_mic_rounded,
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
                      l10n.contactDirectChannels,
                      style: AppTextStyles.font18Bold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                    Text(
                      l10n.footerContactTeam,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: colors.neutral600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Official Clickable Phone Number: 0101591764
          _InteractiveContactTile(
            icon: Icons.phone_rounded,
            title: l10n.contactPhone,
            subtitle: l10n.contactPhoneDesc,
            url: 'tel:0101591764',
            tooltip: 'Call 0101591764',
            isPrimaryHighlight: true,
          ),
          const SizedBox(height: 14),

          // Official Clickable Email: support@sustina.io
          _InteractiveContactTile(
            icon: Icons.email_rounded,
            title: l10n.contactSupportEmail,
            subtitle: l10n.contactSupportEmailDesc,
            url: 'mailto:support@sustina.io',
            tooltip: 'Email support@sustina.io',
          ),
          const SizedBox(height: 22),

          // Guaranteed Response SLA Badge
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark
                  ? colors.secondary100
                  : colors.secondary100.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: colors.secondary500.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_outlined,
                  size: 20,
                  color: isDark
                      ? colors.secondary600
                      : colors.secondary700,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l10n.contactSlaBadge,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: colors.neutral900,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Official Sustina Social media links
          Text(
            l10n.socialFollowUs,
            style: AppTextStyles.font12Bold.copyWith(
              color: colors.neutral800,
            ),
          ),
          const SizedBox(height: 10),
          const SustinaSocialLinksRow(
            spacing: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildFormOrSuccess(BuildContext context, AppLocalizations l10n) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: _isSubmitted
          ? Container(
              key: const ValueKey('contact_success'),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: isDark ? colors.grey100 : colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colors.primary500.withValues(alpha: 0.5),
                  width: 1.4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colors.black.withValues(
                      alpha: isDark ? 0.30 : 0.06,
                    ),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SustinaSuccessGraphic(size: 96),
                  const SizedBox(height: 16),
                  Text(
                    l10n.contactSuccessTitle,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font20Bold.copyWith(
                      color: colors.neutral900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.contactSuccessDesc,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font14Regular.copyWith(
                      color: colors.neutral700,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SustinaSecondaryButton(
                    label: l10n.contactSendAnother,
                    icon: Icons.refresh_rounded,
                    onPressed: _resetForm,
                  ),
                ],
              ),
            )
          : Container(
              key: const ValueKey('contact_form'),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: isDark ? colors.grey100 : colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: colors.grey200, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: colors.black.withValues(
                      alpha: isDark ? 0.28 : 0.05,
                    ),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.contactFormTitle,
                      style: AppTextStyles.font18Bold.copyWith(
                        color: colors.neutral900,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // User Name
                    SustinaFormField(
                      controller: _nameController,
                      label: l10n.fieldName,
                      hint: l10n.hintName,
                      prefixIcon: Icons.person_outline_rounded,
                      validator: (v) => AppValidators.validateName(
                        v,
                        requiredMessage: l10n.valRequiredField,
                        minLengthMessage: l10n.valNameMin,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Phone & Email Row or Stack
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 480;
                        final phoneField = SustinaFormField(
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
                        );
                        final emailField = SustinaFormField(
                          controller: _emailController,
                          label: l10n.fieldCompanyEmail,
                          hint: l10n.hintCompanyEmail,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => AppValidators.validateEmail(
                            v,
                            requiredMessage: l10n.valEmailRequired,
                            invalidMessage: l10n.valEmailInvalid,
                          ),
                        );

                        if (isCompact) {
                          return Column(
                            children: [
                              phoneField,
                              const SizedBox(height: 16),
                              emailField,
                            ],
                          );
                        }
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: phoneField),
                            const SizedBox(width: 14),
                            Expanded(child: emailField),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Message Content
                    SustinaFormField(
                      controller: _messageController,
                      label: l10n.fieldMessage,
                      hint: l10n.hintMessage,
                      prefixIcon: Icons.message_outlined,
                      maxLines: 4,
                      textInputAction: TextInputAction.newline,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return l10n.valMessageRequired;
                        }
                        if (v.trim().length < 10) {
                          return l10n.valMessageMin;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22),

                    SustinaPrimaryButton(
                      label: l10n.contactSubmitButton,
                      loadingLabel: l10n.contactSubmitting,
                      isLoading: _isSubmitting,
                      fullWidth: true,
                      borderRadius: 14,
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      onPressed: _handleSubmit,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _InteractiveContactTile extends StatefulWidget {
  const _InteractiveContactTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.tooltip,
    this.isPrimaryHighlight = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String url;
  final String tooltip;
  final bool isPrimaryHighlight;

  @override
  State<_InteractiveContactTile> createState() =>
      _InteractiveContactTileState();
}

class _InteractiveContactTileState extends State<_InteractiveContactTile> {
  bool _isHovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    try {
      await launchUrl(uri);
    } catch (e) {
      debugPrint('Could not launch ${widget.url}: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customAppColors;
    final isDark = context.isDarkMode;

    final primaryAccent = isDark ? colors.primary700 : colors.primary600;
    final cardBg = _isHovered
        ? (isDark
            ? colors.primary500.withValues(alpha: 0.16)
            : colors.primary100.withValues(alpha: 0.65))
        : (isDark
            ? colors.grey50
            : (widget.isPrimaryHighlight
                ? colors.primary100.withValues(alpha: 0.3)
                : colors.grey50));

    final borderColor = _isHovered
        ? primaryAccent
        : (widget.isPrimaryHighlight
            ? primaryAccent.withValues(alpha: 0.35)
            : colors.grey200);

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _launch,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: borderColor,
                width: widget.isPrimaryHighlight || _isHovered ? 1.3 : 1.0,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: primaryAccent.withValues(alpha: 0.18),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? primaryAccent
                        : primaryAccent.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: _isHovered ? colors.white : primaryAccent,
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
                          color: _isHovered ? primaryAccent : colors.neutral900,
                          letterSpacing: widget.isPrimaryHighlight ? 0.8 : 0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: colors.neutral600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 16,
                  color: _isHovered ? primaryAccent : colors.grey400,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
