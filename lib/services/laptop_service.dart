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
      if (params.manufacturer != null) {
        for (var mf in params.manufacturer) {
          manufacturerSuffix += 'Manufacturer=$mf&';
        }
      }
      if (params.processor != null) {
        for (var proc in params.processor) {
          processorSuffix += 'Processor=$proc&';
        }
      }
      if (params.graphics != null) {
        for (var graph in params.graphics) {
          graphicsSuffix += 'Graphics=$graph&';
        }
      }
      if (params.ram != null) {
        for (var ram in params.ram) {
          ramSuffix += 'RAM=$ram&';
        }
      }
      if (params.ssd != null) {
        for (var ssd in params.ssd) {
          ssdSuffix += 'SSD=$ssd&';
        }
      }
      if (params.screen != null) {
        for (var screen in params.screen) {
          screenSuffix += 'Screen=$screen&';
        }
      }
      if (params.os != null) {
        for (var os in params.os) {
          osSuffix += 'OS=$os&';
        }
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

  Future<List<String>> getSearchOptions(String nameCriterion) async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/laptops/names?name=$nameCriterion',
        headers: headers);
    if (response.statusCode == 200) {
      List<String> options = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        options.add(item.toString());
      }
      return options;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<String>> getManufacturers() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/manufacturers', headers: headers);
    if (response.statusCode == 200) {
      List<String> manufacturers = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        manufacturers.add(item.toString());
      }
      return manufacturers;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<String>> getProcessors() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/processors', headers: headers);
    if (response.statusCode == 200) {
      List<String> processors = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        processors.add(item.toString());
      }
      return processors;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<String>> getGraphics() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/graphics', headers: headers);
    if (response.statusCode == 200) {
      List<String> graphics = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        graphics.add(item.toString());
      }
      return graphics;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<int>> getRam() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/laptops/ram', headers: headers);
    if (response.statusCode == 200) {
      List<int> ram = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        ram.add(item);
      }
      return ram;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<int>> getSsd() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/laptops/ssd', headers: headers);
    if (response.statusCode == 200) {
      List<int> ssd = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        ssd.add(item);
      }
      return ssd;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<double>> getScreens() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/screens', headers: headers);
    if (response.statusCode == 200) {
      List<double> screens = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        screens.add(item + .0);
      }
      return screens;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<List<String>> getOS() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response = await http.get('$_baseUrl/laptops/OS', headers: headers);
    if (response.statusCode == 200) {
      List<String> os = [];
      var data = jsonDecode(response.body);
      for (var item in data) {
        os.add(item.toString());
      }
      return os;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<double> getMinWeight() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/min-weight', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) + .0;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<double> getMaxWeight() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/max-weight', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) + .0;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<double> getMinPrice() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/min-price', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) + .0;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }

  Future<double> getMaxPrice() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('apiAccessToken');
    var headers = {
      'Authorization': 'Bearer ' + token,
      'Accept': 'application/json',
      'content-type': 'application/json'
    };
    var response =
        await http.get('$_baseUrl/laptops/max-price', headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) + .0;
    } else {
      throw Exception('Помилка при завантаженні даних');
    }
  }
}
