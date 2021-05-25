import 'package:webox/config/query_params/laptop_params.dart';

class PersonalReviewArguments {
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;

  PersonalReviewArguments(
    this.isEmployee,
    this.pageIndex,
    this.sortOrder,
    this.laptopQueryParams,
  );
}
