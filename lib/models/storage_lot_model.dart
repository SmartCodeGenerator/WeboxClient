class StorageLotModel {
  String warehouseAddress;
  double laptopsCostPerUnit;
  String laptopId;
  String delivererId;

  StorageLotModel(this.warehouseAddress, this.laptopsCostPerUnit, this.laptopId,
      this.delivererId);

  Map<String, dynamic> toJson() {
    return {
      'warehouseAddress': warehouseAddress,
      'laptopsCostPerUnit': laptopsCostPerUnit + .0,
      'laptopId': laptopId,
      'delivererId': delivererId,
    };
  }
}
