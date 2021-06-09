class StorageLotInfoModel {
  String id;
  String warehouseAddress;
  DateTime supplyDateTime;
  int laptopsAmount;
  double laptopsCostPerUnit;
  String laptopId;
  String delivererId;

  StorageLotInfoModel(
    this.id,
    this.warehouseAddress,
    this.supplyDateTime,
    this.laptopsAmount,
    this.laptopsCostPerUnit,
    this.laptopId,
    this.delivererId,
  );

  StorageLotInfoModel.fromJson(Map<String, dynamic> jsonObject) {
    id = jsonObject['storageLotId'];
    warehouseAddress = jsonObject['warehouseAddress'];
    supplyDateTime = DateTime.parse(jsonObject['supplyDateTime']);
    laptopsAmount = jsonObject['laptopsAmount'];
    laptopsCostPerUnit = jsonObject['laptopsCostPerUnit'] + .0;
    laptopId = jsonObject['laptopId'];
    delivererId = jsonObject['delivererId'];
  }
}
