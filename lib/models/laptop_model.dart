import 'package:webox/models/review_model.dart';

class LaptopModel {
  String modelName;
  String manufacturer;
  String processor;
  String graphic;
  int ram;
  int ssd;
  double screen;
  String os;
  double weight;
  double price;
  double rating;
  bool isAvailable;
  String modelImagePath;

  LaptopModel(
    this.modelName,
    this.manufacturer,
    this.processor,
    this.graphic,
    this.ram,
    this.ssd,
    this.screen,
    this.os,
    this.weight,
    this.price,
    this.rating,
    this.isAvailable,
    this.modelImagePath,
  );

  Map<String, dynamic> toJson() {
    return {
      'modelName': modelName,
      'manufacturer': manufacturer,
      'processor': processor,
      'graphic': graphic,
      'ram': ram,
      'ssd': ssd,
      'screen': screen,
      'os': os,
      'weight': weight,
      'price': price,
      'rating': rating,
      'isAvailable': isAvailable,
      'modelImagePath': modelImagePath,
    };
  }
}

class LaptopWithIdModel extends LaptopModel {
  String id;
  List<ReviewInfoModel> reviews;

  LaptopWithIdModel(
    this.id,
    String modelName,
    String manufacturer,
    String processor,
    String graphic,
    int ram,
    int ssd,
    double screen,
    String os,
    double weight,
    double price,
    double rating,
    bool isAvailable,
    String modelImagePath,
    this.reviews,
  ) : super(modelName, manufacturer, processor, graphic, ram, ssd, screen, os,
            weight, price, rating, isAvailable, modelImagePath);
}
