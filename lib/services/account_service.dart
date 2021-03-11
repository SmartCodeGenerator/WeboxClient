import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/models/login_model.dart';
import 'package:http/http.dart' show Client;

class AccountService {
  Client client = new Client();
  String _baseUrl;

  AccountService(this._baseUrl);

  Future<String> login(LoginModel model) async {
    var response = await client.post('$_baseUrl/users/login');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }

  Future<AccountModel> getAccountInformation() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {'Authorization': token};
    var response = await client.get('$_baseUrl/users/account-information',
        headers: headers);
    if (response.statusCode == 200) {
      return AccountModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }
}
