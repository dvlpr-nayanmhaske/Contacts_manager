import 'package:get/get_utils/src/get_utils/get_utils.dart';

class Validators {
  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (value.length < 10) {
      return 'Enter valid phone number';
    }

    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (!GetUtils.isEmail(value)) {
      return 'Enter valid email';
    }

    return null;
  }
}
