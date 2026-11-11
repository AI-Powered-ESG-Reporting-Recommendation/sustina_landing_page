import 'package:flutter/material.dart';
import 'package:suatina_web_project/core/theme/app_texts/app_text_styles.dart';
import 'package:suatina_web_project/core/theme/theme_manager/theme_extensions.dart';

class AppSnackBar {
  /// ================== Error ==================
  static void showError(BuildContext context, String message) {
    final colors = context.customAppColors;
    _show(
      context,
      message: message,
      backgroundColor: colors.error700,
      foregroundColor: context.isDarkMode ? colors.grey0 : colors.white,
      icon: Icons.error_outline_rounded,
    );
  }

  /// ================== Success ==================
  static void showSuccess(BuildContext context, String message) {
    final colors = context.customAppColors;
    _show(
      context,
      message: message,
      backgroundColor: colors.primary500,
      foregroundColor: context.isDarkMode ? colors.grey0 : colors.white,
      icon: Icons.check_circle_outline_rounded,
    );
  }

  /// ================== Info ==================
  static void showInfo(BuildContext context, String message) {
    final colors = context.customAppColors;
    _show(
      context,
      message: message,
      backgroundColor: colors.info700,
      foregroundColor: context.isDarkMode ? colors.grey0 : colors.white,
      icon: Icons.info_outline_rounded,
    );
  }

  /// ================== Core Method ==================
  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
    required IconData icon,
  }) {
    final colors = context.customAppColors;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.background.withValues(alpha: 0),
        elevation: 0,
        duration: const Duration(seconds: 3),
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: 0.16),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: foregroundColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyles.font14Medium.copyWith(
                    color: foregroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
