import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/models/change_password_model.dart';
import 'package:webox/models/edit_user_info_model.dart';
import 'package:webox/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:webox/models/register_model.dart';
import 'package:webox/models/reset_password_model.dart';

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

  Future<String> register(RegisterModel model) async {
    var headers = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$_baseUrl/users/register',
        body: jsonEncode(model.toJson()), headers: headers);
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

  Future<int> restorePassword(String email) async {
    var headers = {
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$_baseUrl/users/password/restore',
        body: jsonEncode(email), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> updateProfileImage(String profileImagePath) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/users/profile-image',
        body: jsonEncode(profileImagePath), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> editAccountInformation(EditUserInfoModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/users/account-information',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<String> getUpdateEmailVerificationCode() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/users/email', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return '401';
    } else {
      return 'Помилка при відправці коду верифікації';
    }
  }

  Future<int> updateEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/users/email',
        body: jsonEncode(email), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<int> changePassword(ChangePasswordModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/users/password/change',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }

  Future<String> getPasswordResetVerificationCode() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/users/password/reset', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      return '401';
    } else {
      return 'Помилка при відправці коду верифікації';
    }
  }

  Future<int> resetPassword(ResetPasswordModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/users/password/reset',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode != 200) {
      print(response.body);
    }
    return response.statusCode;
  }
}
