import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/laptop_page_model.dart';
import 'package:http/http.dart' as http;
import 'package:webox/models/review_model.dart';
import 'package:webox/models/storage_lot_info_model.dart';

class LaptopService {
  String _baseUrl;

  LaptopService(this._baseUrl);

  Future<LaptopPageModel> getLaptopPage(
      int pageIndex, String sortOrder, LaptopQueryParams params) async {
    String sortOrderSuffix = '?sortOrder=$sortOrder&' ?? '?';
    String modelNameSuffix = '';
    String manufacturerSuffix = '';
    String processorSuffix = '';
    String graphicsSuffix = '';
    String ramSuffix = '';
    String ssdSuffix = '';
    String screenSuffix = '';
    String osSuffix = '';
    String minWeightSuffix = '';
    String maxWeightSuffix = '';
    String minPriceSuffix = '';
    String maxPriceSuffix = '';
    if (params != null) {
      if (params.modelName != null && params.modelName.trim().length > 0) {
        modelNameSuffix = 'ModelName=${params.modelName}&';
      }
      if (params.manufacturer != null &&
          params.manufacturer.trim().length > 0) {
        manufacturerSuffix = 'Manufacturer=${params.manufacturer}&';
      }
      if (params.processor != null && params.processor.trim().length > 0) {
        processorSuffix = 'Processor=${params.processor}&';
      }
      if (params.graphics != null && params.graphics.trim().length > 0) {
        graphicsSuffix = 'Graphics=${params.graphics}&';
      }
      if (params.ram > 0) {
        ramSuffix = 'RAM=${params.ram}&';
      }
      if (params.ssd > 0) {
        ssdSuffix = 'SSD=${params.ssd}&';
      }
      if (params.screen > 0) {
        screenSuffix = 'Screen=${params.modelName}&';
      }
      if (params.os != null && params.os.trim().length > 0) {
        osSuffix = 'OS=${params.modelName}&';
      }
      if (params.minWeight <= params.maxWeight && params.maxWeight != 0) {
        minWeightSuffix = 'MinWeight=${params.minWeight}&';
        maxWeightSuffix = 'MaxWeight=${params.maxWeight}&';
      }
      if (params.minPrice <= params.maxPrice && params.maxPrice != 0) {
        minPriceSuffix = 'MinPrice=${params.minPrice}&';
        maxPriceSuffix = 'MaxPrice=${params.maxPrice}&';
      }
    }
    String suffix = sortOrderSuffix +
        modelNameSuffix +
        manufacturerSuffix +
        processorSuffix +
        graphicsSuffix +
        ramSuffix +
        ssdSuffix +
        screenSuffix +
        osSuffix +
        minWeightSuffix +
        maxWeightSuffix +
        minPriceSuffix +
        maxPriceSuffix +
        'pageIndex=$pageIndex';
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/laptops$suffix', headers: headers);
    if (response.statusCode == 200) {
      return LaptopPageModel.fromJson(
          jsonDecode(response.headers['x-pagination']),
          jsonDecode(response.body));
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<LaptopWithIdModel> getLaptop(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/laptops/$id', headers: headers);
    if (response.statusCode == 200) {
      var parsedJson = jsonDecode(response.body);
      return LaptopWithIdModel(
        parsedJson['id'],
        parsedJson['modelName'],
        parsedJson['manufacturer'],
        parsedJson['processor'],
        parsedJson['graphic'],
        parsedJson['ram'],
        parsedJson['ssd'],
        parsedJson['screen'] + .0,
        parsedJson['os'],
        parsedJson['weight'] + .0,
        parsedJson['price'] + .0,
        parsedJson['rating'] + .0,
        parsedJson['isAvailable'],
        parsedJson['modelImagePath'],
        parsedJson['reviews'] != null
            ? parsedJson['reviews']
                .map<ReviewInfoModel>((data) => ReviewInfoModel.fromJson(data))
                .toList()
            : [],
        parsedJson['storageLots'] != null
            ? parsedJson['storageLots']
                .map<StorageLotInfoModel>(
                    (jsonObject) => StorageLotInfoModel.fromJson(jsonObject))
                .toList()
            : [],
      );
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<bool> addLaptop(LaptopModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.post('$_baseUrl/laptops',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<bool> updateLaptop(String id, LaptopModel model) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.put('$_baseUrl/laptops/$id',
        body: jsonEncode(model.toJson()), headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }

  Future<bool> deleteLaptop(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.delete('$_baseUrl/laptops/$id', headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }
}
