import 'package:flutter/material.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/config/screen_args/review_form_arguments.dart';
import 'package:webox/models/review_model.dart';
import 'package:webox/ui_components/utils/laptop_review.dart';

class LaptopReviews extends StatelessWidget {
  final List<ReviewInfoModel> reviews;
  final String laptopId, sortOrder;
  final bool isEmployee;
  final int pageIndex;
  final LaptopQueryParams laptopQueryParams;

  LaptopReviews(this.reviews, this.laptopId, this.isEmployee, this.pageIndex,
      this.sortOrder, this.laptopQueryParams);

  @override
  Widget build(BuildContext context) {
    var model = ReviewFormModel();
    model.laptopId = laptopId;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: reviews.map((model) => LaptopReview(model)).toList(),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/reviews/form',
              arguments: ReviewFormArguments(
                model,
                isEmployee,
                pageIndex,
                sortOrder,
                laptopQueryParams,
                false,
                null,
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'НАПИСАТИ ВІДГУК',
              style: TextStyle(
                fontSize: 16.33,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
