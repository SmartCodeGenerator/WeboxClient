import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/ui_components/utils/laptop_info_main_page.dart';
import 'package:webox/ui_components/utils/laptop_reviews.dart';

class LaptopInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as LaptopInfoArguments;
    laptopBloc.fetchLaptopModel(arguments.id);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Webox',
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'все про товар'.toUpperCase(),
              ),
              Tab(
                text: 'відгуки'.toUpperCase(),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: StreamBuilder(
              stream: laptopBloc.laptopModel,
              builder: (context, AsyncSnapshot<LaptopWithIdModel> snapshot) {
                if (snapshot.hasData) {
                  var model = snapshot.data;
                  var reviews = model.reviews;
                  reviews.sort(
                      (r1, r2) => r2.pubDateTime.compareTo(r1.pubDateTime));
                  return TabBarView(
                    children: [
                      LaptopInfoMainPage(
                        arguments,
                        model,
                      ),
                      LaptopReviews(
                        reviews,
                        arguments.id,
                        arguments.isEmployee,
                        arguments.pageIndex,
                        arguments.sortOrder,
                        arguments.laptopQueryParams,
                      ),
                    ],
                  );
                }
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
