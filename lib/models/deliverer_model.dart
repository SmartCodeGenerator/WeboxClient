class DelivererModel {
  String companyName;
  String phoneNumber;
  String mainOfficeAddress;

  DelivererModel(
    this.companyName,
    this.phoneNumber,
    this.mainOfficeAddress,
  );

  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'phoneNumber': phoneNumber,
      'mainOfficeAddress': mainOfficeAddress,
    };
  }
}
