import 'package:webox/config/query_params/laptop_params.dart';

class LaptopPageParams {
  int pageIndex = 1;
  String sortOrder = 'rating_desc';
  LaptopQueryParams laptopQueryParams = LaptopQueryParams();
}

final laptopPageParams = LaptopPageParams();
