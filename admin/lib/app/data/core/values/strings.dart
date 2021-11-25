class Strings {
  static ValidationMessages validationMessages = ValidationMessages();
}

class ValidationMessages {
  String emptyEmail = 'Please enter your email';
  String invalidEmail = 'Invalid email';

  String emptyPassword = 'Please create a password';
  String shortPassword = 'Password must be at least 6 characters long';

  //For category Management:
  String emptyCategoryName = 'Category name is required';
}
