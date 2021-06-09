import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/preference_model.dart';
import 'package:http/http.dart' as http;

class PreferenceService {
  final String baseUrl;

  PreferenceService(this.baseUrl);

  Future<List<PreferenceModel>> getPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$baseUrl/preferences', headers: headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<PreferenceModel> preferences = [];
      for (var obj in data) {
        preferences.add(PreferenceModel.fromJson(obj));
      }
      return preferences;
    } else {
      print(response.body);
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<int> addPreference(String laptopId) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$baseUrl/preferences',
        body: jsonEncode(laptopId), headers: headers);
    if (response.statusCode != 200) {
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
    var response = await http.post('$baseUrl/preferences/check-presence',
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

  Future<int> removePreference(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.delete('$baseUrl/preferences/$id', headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }
}
