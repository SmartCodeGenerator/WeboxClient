class DelivererInfoModel {
  String delivererId;
  String companyName;
  String phoneNumber;
  String mainOfficeAddress;

  DelivererInfoModel(
    this.delivererId,
    this.companyName,
    this.phoneNumber,
    this.mainOfficeAddress,
  );

  DelivererInfoModel.fromJson(Map<String, dynamic> jsonData) {
    delivererId = jsonData['delivererId'];
    companyName = jsonData['companyName'];
    phoneNumber = jsonData['phoneNumber'];
    mainOfficeAddress = jsonData['mainOfficeAddress'];
  }
}
