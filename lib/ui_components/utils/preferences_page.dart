import 'package:flutter/material.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/preference_model.dart';
import 'package:webox/ui_components/utils/preference_tile.dart';

class PreferencesPage extends StatelessWidget {
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;

  const PreferencesPage(
      this.isEmployee, this.pageIndex, this.sortOrder, this.laptopQueryParams,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    preferenceBloc.fetchPreferences();
    return StreamBuilder(
      stream: preferenceBloc.preferences,
      builder: (context, AsyncSnapshot<List<PreferenceModel>> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Center(
            child: Text(
              'Помилка при завантаженні вподобань',
              style: TextStyle(
                fontSize: 16.33,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          var preferences = snapshot.data;
          return ListView(
            children: preferences
                .map<PreferenceTile>(
                  (model) => PreferenceTile(
                    model,
                    isEmployee,
                    pageIndex,
                    sortOrder,
                    laptopQueryParams,
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
    );
  }
}
