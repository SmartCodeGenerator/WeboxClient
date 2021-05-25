import 'package:webox/models/review_model.dart';

import 'laptop_model.dart';

class LaptopPageModel {
  int _count;
  int _pageSize;
  int _pageIndex;
  int _totalPages;
  bool _hasNextPage;
  bool _hasPreviousPage;
  List<LaptopWithIdModel> _laptops = [];

  LaptopPageModel.fromJson(
      Map<String, dynamic> parsedHeader, List<dynamic> parsedObjects) {
    _count = parsedHeader['Count'];
    _pageSize = parsedHeader['PageSize'];
    _pageIndex = parsedHeader['PageIndex'];
    _totalPages = parsedHeader['TotalPages'];
    _hasNextPage = parsedHeader['HasNextPage'];
    _hasPreviousPage = parsedHeader['HasPreviousPage'];

    for (var jsonObj in parsedObjects) {
      _laptops.add(LaptopWithIdModel(
        jsonObj['id'],
        jsonObj['modelName'],
        jsonObj['manufacturer'],
        jsonObj['processor'],
        jsonObj['graphic'],
        jsonObj['ram'],
        jsonObj['ssd'],
        jsonObj['screen'] + .0,
        jsonObj['os'],
        jsonObj['weight'] + .0,
        jsonObj['price'] + .0,
        jsonObj['rating'] + .0,
        jsonObj['isAvailable'],
        jsonObj['modelImagePath'],
        jsonObj['reviews'] != null
            ? jsonObj['reviews']
                .map((data) => ReviewInfoModel.fromJson(data))
                .toList()
            : [],
      ));
    }
  }

  int get count => _count;
  int get pageSize => _pageSize;
  int get pageIndex => _pageIndex;
  int get totalPages => _totalPages;
  bool get hasNext => _hasNextPage;
  bool get hasPrevious => _hasPreviousPage;
  List<LaptopWithIdModel> get laptops => _laptops;
}
