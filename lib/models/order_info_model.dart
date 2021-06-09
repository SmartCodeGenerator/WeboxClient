import 'package:webox/models/order_item_model.dart';

class OrderInfoModel {
  String id;
  String deliveryAddress;
  DateTime deliveryDateTime;
  DateTime placementDateTime;
  double price;
  String accountId;
  List<OrderItemModel> orderItems;

  OrderInfoModel(this.id, this.deliveryAddress, this.deliveryDateTime,
      this.placementDateTime, this.price, this.accountId, this.orderItems);

  OrderInfoModel.fromJson(Map<String, dynamic> jsonObject) {
    id = jsonObject['orderId'];
    deliveryAddress = jsonObject['deliveryAddress'];
    deliveryDateTime = DateTime.parse(jsonObject['deliveryDateTime']);
    placementDateTime = DateTime.parse(jsonObject['placementDateTime']);
    price = jsonObject['price'] + .0;
    accountId = jsonObject['accountId'];
    var orderItemsData = jsonObject['orderItems'];
    if (orderItemsData != null) {
      orderItems = [];
      for (var jsonItem in orderItemsData) {
        orderItems.add(OrderItemModel.fromJson(jsonItem));
      }
    }
  }
}
