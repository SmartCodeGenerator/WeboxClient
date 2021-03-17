import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/models/login_model.dart';
import 'package:http/http.dart' as http;

class AccountService {
  String _baseUrl;

  AccountService(this._baseUrl);

  Future<String> login(LoginModel model) async {
    var body = jsonEncode({
      'email': model.email,
      'password': model.password,
    });
    var headers = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.post('$_baseUrl/users/login', body: body, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  Future<AccountModel> getAccountInformation() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/users/account-information', headers: headers);
    if (response.statusCode == 200) {
      return AccountModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }
}
