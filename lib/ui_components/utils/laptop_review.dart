import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/models/review_model.dart';
import 'package:webox/ui_components/utils/utility.dart';

class LaptopReview extends StatelessWidget {
  final ReviewInfoModel model;

  LaptopReview(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model.userName,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  Utility.getFormattedDateString(model.pubDateTime),
                  style: TextStyle(
                    fontSize: 16.33,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            RatingBarIndicator(
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              rating: model.rating,
              itemSize: 25.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              model.text,
              style: TextStyle(
                fontSize: 16.33,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
