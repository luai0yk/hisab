import 'package:hisab/core/validator/email_validator.dart';

abstract class InputValidator {
  static validateInput({
    int? max,
    int? min,
    required String value,
    String? fieldName,
    bool validateEmail = false,
  }) {
    String val = value.trim();
    int length = val.length;

    if (val.isEmpty) {
      return '$fieldName is required.';
    }

    if (validateEmail) {
      if (!EmailValidator.validateEmail(email: val)) {
        return 'Enter a valid email.';
      }
    }

    if (min != null && length < min) {
      return '$fieldName must be at least $min chars.';
    }

    if (max != null && length > max) {
      return '$fieldName must be less than $min.';
    }
  }
}
