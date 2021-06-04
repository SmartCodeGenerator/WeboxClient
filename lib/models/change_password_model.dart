class ChangePasswordModel {
  String currentPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordModel(
      this.currentPassword, this.newPassword, this.confirmNewPassword);

  Map<String, dynamic> toJson() {
    return {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}
