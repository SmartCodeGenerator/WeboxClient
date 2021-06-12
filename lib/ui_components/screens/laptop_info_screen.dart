import 'package:flutter/material.dart';
import 'package:webox/blocs/comparison_bloc.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/ui_components/utils/laptop_info_main_page.dart';
import 'package:webox/ui_components/utils/laptop_reviews.dart';
import 'package:webox/ui_components/utils/laptop_storage_lots.dart';

class LaptopInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as LaptopInfoArguments;
    laptopBloc.fetchLaptopModel(arguments.id);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Webox',
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'опис'.toUpperCase(),
              ),
              Tab(
                text: 'відгуки'.toUpperCase(),
              ),
              arguments.isEmployee
                  ? Tab(
                      text: 'склад'.toUpperCase(),
                    )
                  : Container(),
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
                      FutureBuilder(
                        future:
                            comparisonBloc.getComparisonStatus(arguments.id),
                        builder: (context, AsyncSnapshot<bool> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text(
                                'Помилка при завантаженні інформації про ноутбук',
                                style: TextStyle(
                                  fontSize: 16.33,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            bool isCompared = snapshot.data;
                            return FutureBuilder(
                              future: preferenceBloc
                                  .getPreferenceStatus(arguments.id),
                              builder:
                                  (context, AsyncSnapshot<bool> snapshot2) {
                                if (snapshot2.hasError) {
                                  print(snapshot2.error.toString());
                                  return Center(
                                    child: Text(
                                      'Помилка при завантаженні інформації про ноутбук',
                                      style: TextStyle(
                                        fontSize: 16.33,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  );
                                } else if (snapshot2.hasData) {
                                  bool isPrefered = snapshot2.data;
                                  return LaptopInfoMainPage(
                                    arguments,
                                    model,
                                    isCompared,
                                    isPrefered,
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      LaptopReviews(
                        reviews,
                        arguments.id,
                        arguments.isEmployee,
                        arguments.pageIndex,
                        arguments.sortOrder,
                        arguments.laptopQueryParams,
                      ),
                      LaptopStorageLots(
                        {
                          'storageLots': model.storageLots,
                          'laptopId': arguments.id,
                          'laptopPageArgs': {
                            'pageIndex': arguments.pageIndex,
                            'sortOrder': arguments.sortOrder,
                            'queryParams': arguments.laptopQueryParams,
                          },
                        },
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
