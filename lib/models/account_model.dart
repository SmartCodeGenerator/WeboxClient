class AccountModel {
  String _firstName;
  String _lastName;
  String _email;
  bool _isEmployee;
  String _profileImagePath;

  AccountModel.fromJson(Map<String, dynamic> parsedObject) {
    _firstName = parsedObject['firstName'];
    _lastName = parsedObject['lastName'];
    _email = parsedObject['email'];
    _isEmployee = parsedObject['isEmployee'];
    _profileImagePath = parsedObject['profileImagePath'];
  }

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  bool get isEmployee => _isEmployee;
  String get profileImagePath => _profileImagePath;

  String get fullName => '$_firstName $_lastName';
}
