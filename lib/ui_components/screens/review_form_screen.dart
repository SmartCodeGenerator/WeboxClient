import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/review_bloc.dart';
import 'package:webox/config/screen_args/review_form_arguments.dart';

class ReviewFormScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as ReviewFormArguments;
    var model = arguments.model;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Webox',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Вкажіть рейтинг моделі:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: model.rating ?? 0,
                          allowHalfRating: true,
                          itemSize: 36.0,
                          itemBuilder: (context, _) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                          onRatingUpdate: (rating) {
                            model.rating = rating;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: TextEditingController(text: model.reviewText),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Введіть текст відгуку...',
                      ),
                      onChanged: (text) {
                        model.reviewText = text.trim();
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            if (arguments.isForUpdate) {
                              var resultCode = await reviewBloc.updateReview(
                                  model, arguments.reviewId);
                              if (resultCode == 200) {
                                await laptopBloc
                                    .fetchLaptopModel(model.laptopId);
                                await laptopBloc.fetchLaptopPageModel(
                                    arguments.pageIndex,
                                    arguments.sortOrder,
                                    arguments.laptopQueryParams);
                                await reviewBloc.getReviews();
                                Navigator.pop(context);
                              } else if (resultCode == 401) {
                                Navigator.pushNamed(context, '/login');
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Помилка при відправці даних!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              var resultCode =
                                  await reviewBloc.saveReview(model);
                              if (resultCode == 200) {
                                await laptopBloc
                                    .fetchLaptopModel(model.laptopId);
                                await laptopBloc.fetchLaptopPageModel(
                                    arguments.pageIndex,
                                    arguments.sortOrder,
                                    arguments.laptopQueryParams);
                                Navigator.pop(context);
                              } else if (resultCode == 401) {
                                Navigator.pushNamed(context, '/login');
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Помилка при відправці даних!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 12.0,
                            ),
                            child: Text(
                              'ВІДПРАВИТИ',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
