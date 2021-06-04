class EditUserInfoModel {
  String firstName;
  String lastName;

  EditUserInfoModel(this.firstName, this.lastName);

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
