import 'package:get/get.dart';
import 'package:hisab/core/localization/locale_key.dart';
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
      return '$fieldName ${LocaleKey.isRequired.tr}';
    }

    if (validateEmail) {
      if (!EmailValidator.validateEmail(email: val)) {
        return LocaleKey.enterValidEmail.tr;
      }
    }

    if (min != null && length < min) {
      return '$fieldName ${LocaleKey.mustBeAtLeast.tr} $min ${LocaleKey.chars.tr}.';
    }

    if (max != null && length > max) {
      return '$fieldName ${LocaleKey.mustBeMoreThan.tr} $min ${LocaleKey.chars.tr}.';
    }
  }
}
