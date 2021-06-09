import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/deliverer_info_model.dart';
import 'package:webox/models/deliverer_model.dart';

class DelivererService {
  String baseUrl;

  DelivererService(this.baseUrl);

  Future<dynamic> getDeliverers() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/deliverers', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      return Error();
    }
    var data = jsonDecode(response.body);
    List<DelivererInfoModel> deliverers = [];
    for (var object in data) {
      deliverers.add(DelivererInfoModel.fromJson(object));
    }
    return deliverers;
  }

  Future<DelivererInfoModel> getDeliverer(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/deliverers/$id', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
      return null;
    }
    var data = jsonDecode(response.body);
    return DelivererInfoModel.fromJson(data);
  }

  Future<int> saveDeliverer(DelivererModel data) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$baseUrl/deliverers',
        body: jsonEncode(data.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> updateDeliverer(String id, DelivererModel data) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$baseUrl/deliverers/$id',
        body: jsonEncode(data.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> deleteDeliverer(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.delete('$baseUrl/deliverers/$id', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }
}
