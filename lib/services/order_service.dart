import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/order_info_model.dart';
import 'package:http/http.dart' as http;
import 'package:webox/models/order_model.dart';

class OrderService {
  final String baseUrl;

  OrderService(this.baseUrl);

  Future<List<OrderInfoModel>> getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/orders', headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<OrderInfoModel> orders = [];
      for (var orderData in data) {
        orders.add(OrderInfoModel.fromJson(orderData));
      }
      return orders;
    } else {
      print(response.body);
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<OrderInfoModel> getOrder(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/orders/$id', headers: headers);
    if (response.statusCode == 200) {
      return OrderInfoModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<int> makeOrder(OrderModel model) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$baseUrl/orders',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> cancelOrder(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.delete('$baseUrl/orders/$id', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }
}
