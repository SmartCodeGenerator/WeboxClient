import 'package:webox/config/query_params/laptop_params.dart';

class LaptopInfoArguments {
  String id, sortOrder;
  bool isEmployee;
  int pageIndex;
  LaptopQueryParams laptopQueryParams;

  LaptopInfoArguments(this.id, this.isEmployee, this.pageIndex, this.sortOrder,
      this.laptopQueryParams);
}
