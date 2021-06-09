class ResetPasswordModel {
  String newPassword;
  String confirmNewPassword;

  ResetPasswordModel(this.newPassword, this.confirmNewPassword);

  Map<String, dynamic> toJson() {
    return {
      'newPassword': newPassword,
      'confirmNewPassword': confirmNewPassword,
    };
  }
}
