import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/review_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/config/screen_args/review_form_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/review_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/utils/utility.dart';

import 'popup_dialogs.dart';

class UserReview extends StatelessWidget {
  final ReviewInfoModel model;
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;

  UserReview(
    this.model,
    this.isEmployee,
    this.pageIndex,
    this.sortOrder,
    this.laptopQueryParams,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<LaptopWithIdModel>(
          future: NetworkProvider.laptopService.getLaptop(model.laptopId),
          builder: (context, AsyncSnapshot<LaptopWithIdModel> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error.toString());
            } else if (snapshot.hasData) {
              var laptopModel = snapshot.data;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.network(
                        laptopModel.modelImagePath,
                        height: 50.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          laptopModel.modelName,
                          style: TextStyle(
                            fontSize: 16.33,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    model.text,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBarIndicator(
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        rating: model.rating,
                        itemSize: 25.0,
                      ),
                      Text(
                        Utility.getFormattedDateString(model.pubDateTime),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          var formModel = ReviewFormModel();
                          formModel.laptopId = model.laptopId;
                          formModel.rating = model.rating;
                          formModel.reviewText = model.text;
                          Navigator.pushNamed(
                            context,
                            '/reviews/form',
                            arguments: ReviewFormArguments(
                              formModel,
                              isEmployee,
                              pageIndex,
                              sortOrder,
                              laptopQueryParams,
                              true,
                              model.id,
                            ),
                          );
                        },
                        child: Text(
                          'Редагувати',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          bool confirm = await PopupDialogs.showConfirmDialog(
                              context,
                              'Видалення відгуку',
                              'Видалити даний відгук?');
                          if (confirm) {
                            int statusCode =
                                await reviewBloc.deleteReview(model.id);
                            if (statusCode == 200) {
                              await laptopBloc.fetchLaptopModel(model.laptopId);
                              await laptopBloc.fetchLaptopPageModel(
                                  pageIndex, sortOrder, laptopQueryParams);
                              await reviewBloc.getReviews();
                            } else if (statusCode == 401) {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              final snackBar = SnackBar(
                                content:
                                    Text('Помилка при видаленні об\'єкту!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                        child: Text(
                          'Видалити',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
