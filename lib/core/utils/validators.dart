class Validators {
  // 1. Name Validator (Register Screen)
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  // 2. Email Validator (Login, Register, Forgot Password)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  // 3. Simple Password Validator (Login Screen ke liye - sirf empty na ho)
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  // 4. Strict Password Validator (Register & Reset Password Screen)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    // Check for at least 1 uppercase letter, 1 lowercase letter, and 1 digit
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasDigits = value.contains(RegExp(r'[0-9]'));
    final hasLowercase = value.contains(RegExp(r'[a-z]'));

    if (!hasUppercase || !hasLowercase || !hasDigits) {
      return 'Must include upper, lower case letters and a number';
    }
    return null;
  }

  // 5. Confirm Password Validator (Register & Reset Password)
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  // 6. OTP/Reset Code Validator (Forgot Password / Verify Screen)
  static String? validateOtp(String? value, {int length = 6}) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the verification code';
    }
    if (value.trim().length != length) {
      return 'Code must be $length digits';
    }
    return null;
  }

  // 7. Phone Validator (Optional: agar phone authentication ho)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter phone number';
    }
    final phoneRegex = RegExp(r'^(?:\+92|0)?3[0-9]{9}$'); // Pakistan format
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
}