import 'package:suatina_web_project/core/helpers/app_regex.dart';

class AppValidators {
  static String? validateName(
    String? value, {
    String fieldName = 'Name',
    String? requiredMessage,
    String? minLengthMessage,
  }) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage ?? '$fieldName is required';
    }
    if (value.trim().length < 2) {
      return minLengthMessage ?? '$fieldName must be at least 2 characters';
    }
    return null;
  }

  static String? validatePhone(
    String? value, {
    String? requiredMessage,
    String? invalidMessage,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return requiredMessage ?? 'Phone number is required';
    }

    // Strip spaces, dashes, and parentheses while keeping optional leading +
    final normalized = trimmed.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    final internationalPattern = RegExp(r'^\+?[0-9]{8,15}$');
    final egyptLocal = RegExp(r'^01[0-9]{9}$');
    final saudiLocal = RegExp(r'^05[0-9]{8}$');

    if (!internationalPattern.hasMatch(normalized) &&
        !egyptLocal.hasMatch(normalized) &&
        !saudiLocal.hasMatch(normalized)) {
      return invalidMessage ?? 'Invalid phone number';
    }

    return null;
  }

  static String? validateEmail(
    String? value, {
    String? requiredMessage,
    String? invalidMessage,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return requiredMessage ?? 'Email is required';
    }

    if (!AppRegex.isEmailValid(trimmed)) {
      return invalidMessage ?? 'Invalid email address';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (!AppRegex.hasMinLength(value)) {
      return 'Password must be at least 8 characters';
    }
    if (!AppRegex.hasUpperCase(value)) {
      return 'Must contain at least one uppercase letter';
    }
    if (!AppRegex.hasLowerCase(value)) {
      return 'Must contain at least one lowercase letter';
    }
    if (!AppRegex.hasNumber(value)) {
      return 'Must contain at least one number';
    }
    if (!AppRegex.hasSpecialCharacter(value)) {
      return 'Must contain a special character';
    }

    return null;
  }

  static String? validateRequired(
    dynamic value, {
    String fieldName = 'field',
    String? requiredMessage,
  }) {
    if (value == null || (value is String && value.trim().isEmpty)) {
      return requiredMessage ?? 'Please select $fieldName';
    }
    return null;
  }
}
