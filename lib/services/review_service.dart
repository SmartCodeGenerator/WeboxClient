import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/models/review_model.dart';
import 'package:http/http.dart' as http;

class ReviewService {
  String _baseUrl;

  ReviewService(this._baseUrl);

  Future<dynamic> getReviews() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/reviews', headers: headers);
    if (response.statusCode == 200) {
      var reviewsData = jsonDecode(response.body);
      return reviewsData
          .map<ReviewInfoModel>((data) => ReviewInfoModel.fromJson(data))
          .toList();
    }
    return response.statusCode;
  }

  Future<dynamic> getReview(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/reviews/$id', headers: headers);
    if (response.statusCode == 200) {
      return ReviewInfoModel.fromJson(jsonDecode(response.body));
    }
    return response.statusCode;
  }

  Future<int> saveReview(ReviewFormModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$_baseUrl/reviews',
        body: jsonEncode(model.toJson()), headers: headers);
    return response.statusCode;
  }

  Future<int> updateReview(ReviewFormModel model, String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/reviews/$id',
        body: jsonEncode(model.toJson()), headers: headers);
    return response.statusCode;
  }

  Future<int> deleteReview(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.delete('$_baseUrl/reviews/$id', headers: headers);
    return response.statusCode;
  }
}
