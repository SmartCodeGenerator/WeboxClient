import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:webox/models/storage_lot_info_model.dart';
import 'package:webox/models/storage_lot_model.dart';
import 'package:webox/models/storage_replenishment_model.dart';

class StorageLotService {
  final String baseUrl;

  StorageLotService(this.baseUrl);

  Future<List<StorageLotInfoModel>> getStorageLots() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/storage-lots', headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<StorageLotInfoModel> lots = [];
      for (var jsonObject in data) {
        lots.add(StorageLotInfoModel.fromJson(jsonObject));
      }
      return lots;
    } else {
      print(response.body);
      throw Exception('Помилка при завантаженні комірок сховища');
    }
  }

  Future<StorageLotInfoModel> getStorageLot(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$baseUrl/storage-lots/$id', headers: headers);
    if (response.statusCode == 200) {
      return StorageLotInfoModel.fromJson(jsonDecode(response.body));
    } else {
      print(response.body);
      return null;
    }
  }

  Future<dynamic> getLaptopAmount(String laptopId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http
        .get('$baseUrl/storage-lots/laptop-amount/$laptopId', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.body);
      return {
        'statusCode': response.statusCode,
      };
    }
  }

  Future<int> saveStorageLot(StorageLotModel model) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$baseUrl/storage-lots',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> updateStorageLot(String id, StorageLotModel model) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$baseUrl/storage-lots/$id',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> replenishStorageLot(
      String id, StorageReplenishmentModel model) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$baseUrl/storage-lots/replenish/$id',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> deleteStorageLot(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.delete('$baseUrl/storage-lots/$id', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }
}
