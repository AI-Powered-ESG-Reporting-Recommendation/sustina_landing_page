import 'package:suatina_web_project/core/helpers/app_regex.dart';

class AppValidators {
  static String? validateName(String? value, {String fieldName = "Name"}) {
    if (value == null || value.trim().isEmpty) {
      return "$fieldName is required";
    }
    if (value.trim().length < 2) {
      return "$fieldName must be at least 2 characters";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    final local = RegExp(r'^01[0-9]{9}$');
    final international = RegExp(r'^\+201[0-9]{9}$');

    if (!local.hasMatch(value) && !international.hasMatch(value)) {
      return "Invalid phone number";
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!AppRegex.isEmailValid(value)) {
      return "Invalid email address";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (!AppRegex.hasMinLength(value)) {
      return "Password must be at least 8 characters";
    }
    if (!AppRegex.hasUpperCase(value)) {
      return "Must contain at least one uppercase letter";
    }
    if (!AppRegex.hasLowerCase(value)) {
      return "Must contain at least one lowercase letter";
    }
    if (!AppRegex.hasNumber(value)) {
      return "Must contain at least one number";
    }
    if (!AppRegex.hasSpecialCharacter(value)) {
      return "Must contain a special character";
    }

    return null;
  }

  static String? validateRequired(dynamic value, {String fieldName = "field"}) {
    if (value == null) {
      return "Please select $fieldName";
    }
    return null;
  }
}
