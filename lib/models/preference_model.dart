import 'package:webox/models/laptop_model.dart';

import 'review_model.dart';
import 'storage_lot_info_model.dart';

class PreferenceModel {
  String id;
  LaptopWithIdModel laptopModel;

  PreferenceModel(this.id, this.laptopModel);

  PreferenceModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    laptopModel = LaptopWithIdModel(
      jsonData['laptopData']['id'],
      jsonData['laptopData']['modelName'],
      jsonData['laptopData']['manufacturer'],
      jsonData['laptopData']['processor'],
      jsonData['laptopData']['graphic'],
      jsonData['laptopData']['ram'],
      jsonData['laptopData']['ssd'],
      jsonData['laptopData']['screen'] + .0,
      jsonData['laptopData']['os'],
      jsonData['laptopData']['weight'] + .0,
      jsonData['laptopData']['price'] + .0,
      jsonData['laptopData']['rating'] + .0,
      jsonData['laptopData']['isAvailable'],
      jsonData['laptopData']['modelImagePath'],
      jsonData['laptopData']['reviews'] != null
          ? jsonData['laptopData']['reviews']
              .map<ReviewInfoModel>((data) => ReviewInfoModel.fromJson(data))
              .toList()
          : [],
      jsonData['laptopData']['storageLots'] != null
          ? jsonData['laptopData']['storageLots']
              .map<StorageLotInfoModel>(
                  (jsonObject) => StorageLotInfoModel.fromJson(jsonObject))
              .toList()
          : [],
    );
  }
}
