class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  bool isEmployee = false;
  String profileImagePath;

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'isEmployee': isEmployee,
      'profileImagePath': profileImagePath,
    };
  }
}
