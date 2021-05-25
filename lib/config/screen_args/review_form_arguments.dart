import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/review_model.dart';

class ReviewFormArguments {
  final ReviewFormModel model;
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;
  final bool isForUpdate;
  final String reviewId;

  ReviewFormArguments(
    this.model,
    this.isEmployee,
    this.pageIndex,
    this.sortOrder,
    this.laptopQueryParams,
    this.isForUpdate,
    this.reviewId,
  );
}
