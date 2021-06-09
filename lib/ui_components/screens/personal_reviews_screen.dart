import 'package:flutter/material.dart';
import 'package:webox/blocs/review_bloc.dart';
import 'package:webox/config/screen_args/personal_review_arguments.dart';
import 'package:webox/models/review_model.dart';
import 'package:webox/ui_components/utils/user_review.dart';

class PersonalReviewsScreen extends StatelessWidget {
  void fetchData(BuildContext context) async {
    var statusCode = await reviewBloc.getReviews();
    if (statusCode == 401) {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchData(context);
    var args =
        ModalRoute.of(context).settings.arguments as PersonalReviewArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Webox',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: reviewBloc.reviews,
            builder: (context, AsyncSnapshot<List<ReviewInfoModel>> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              } else if (snapshot.hasData) {
                var reviews = snapshot.data;
                reviews
                    .sort((r1, r2) => r2.pubDateTime.compareTo(r1.pubDateTime));
                return ListView(
                  children: reviews
                      .map<UserReview>(
                        (model) => UserReview(
                          model,
                          args.isEmployee,
                          args.pageIndex,
                          args.sortOrder,
                          args.laptopQueryParams,
                          key: ObjectKey(model),
                        ),
                      )
                      .toList(),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
