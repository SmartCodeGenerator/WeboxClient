import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/comparison_model.dart';
import 'package:http/http.dart' as http;

class ComparisonService {
  final String baseUrl;

  ComparisonService(this.baseUrl);

  Future<List<ComparisonModel>> getComparisons() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/comparisons', headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<ComparisonModel> comparisons = [];
      for (var obj in data) {
        comparisons.add(ComparisonModel.fromJson(obj));
      }
      return comparisons;
    } else {
      print(response.body);
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<int> addComparison(String laptopId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$baseUrl/comparisons',
        body: jsonEncode(laptopId), headers: headers);
    if (response.statusCode != 200) {
      print(response.statusCode);
      print(response.body);
    }
    return response.statusCode;
  }

  Future<bool> checkPresence(String laptopId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$baseUrl/comparisons/check-presence',
        body: jsonEncode(laptopId), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      print(response.body);
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<int> removeComparison(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.delete('$baseUrl/comparisons/$id', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }
}
