class OrderItemModel {
  int amount;
  String laptopId;

  OrderItemModel(this.amount, this.laptopId);

  OrderItemModel.fromJson(Map<String, dynamic> jsonObject) {
    amount = jsonObject['amount'];
    laptopId = jsonObject['laptopId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'laptopId': laptopId,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'laptop_id': laptopId,
    };
  }
}
