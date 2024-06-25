class RegExceprission {
  static bool isValidEmail(String email) {
    // Define the regular expression
    final RegExp emailRegex =
        RegExp(r'^[^\s@]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,3}$');

    // Check if the email matches the regular expression
    return emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    // Define the regular expression
    final RegExp passwordRegex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    // Check if the password matches the regular expression
    return passwordRegex.hasMatch(password);
  }

  static bool validatePhoneNumberOne(String phoneNumber) {
    // Regular expression pattern to match the phone number format
    final RegExp pattern = RegExp(r'^\+962(77|78|79)\d{7}$');

    // Check if the phone number matches the regular expression pattern
    return pattern.hasMatch(phoneNumber);
  }

  static bool validatePhoneNumberTwo(String phoneNumber) {
    // Regular expression pattern to match the phone number format
    final RegExp pattern = RegExp(r'^(079|077|078)\d{7}$');

    // Check if the phone number matches the regular expression pattern
    return pattern.hasMatch(phoneNumber);
  }
}
