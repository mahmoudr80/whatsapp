import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class Validators {

  /// Returns an error string if invalid, otherwise null
 static String? phoneValidator(String?value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    try {
      // Parse the number — automatically detects country from + code
      final phone = PhoneNumber.parse(value);

      // Validate the number
      if (!phone.isValid()) {
        return 'Invalid phone number';
      }

      return null; // Valid
    } catch (e) {
      return 'Invalid phone number';
    }
  }

}
