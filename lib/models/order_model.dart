import 'package:webox/models/order_item_model.dart';

class OrderModel {
  String deliveryAddress;
  double price;
  List<OrderItemModel> orderItems;

  OrderModel(this.deliveryAddress, this.price, this.orderItems);

  Map<String, dynamic> toJson() {
    return {
      'deliveryAddress': deliveryAddress,
      'price': price,
      'orderItems':
          orderItems.map<Map<String, dynamic>>((e) => e.toJson()).toList(),
    };
  }
}
