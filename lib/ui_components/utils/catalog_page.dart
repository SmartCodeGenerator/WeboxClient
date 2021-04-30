import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/laptop_page_model.dart';
import 'package:webox/ui_components/utils/laptop_tile.dart';

class CatalogPage extends StatefulWidget {
  final bool isEmployee;

  CatalogPage(this.isEmployee);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final Map<String, String> sortMap = {
    'rating_desc': 'За рейтингом',
    'price_asc': 'Від дешевих до дорогих',
    'price_desc': 'Від дорогих до дешевих'
  };
  String sortOrder;
  LaptopQueryParams params;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    sortOrder = sortMap.keys.first;
    laptopBloc.fetchLaptopPageModel(_page, sortOrder, null);
  }

  Row buildCatalogRow(List<Widget> children) => Row(
        children: children,
      );

  List<Widget> buildLaptopTiles(List<LaptopWithIdModel> laptops) {
    List<Row> rows = [];
    for (int i = 0; i < laptops.length ~/ 2; i++) {
      var row = buildCatalogRow([
        Expanded(
          flex: 1,
          child: LaptopTile(
            model: laptops[2 * i],
            isEmployee: widget.isEmployee,
          ),
        ),
        Expanded(
          flex: 1,
          child: LaptopTile(
            model: laptops[(2 * i) + 1],
            isEmployee: widget.isEmployee,
          ),
        ),
      ]);
      rows.add(row);
    }
    if (laptops.length % 2 != 0) {
      var row = buildCatalogRow([
        Expanded(
          flex: 1,
          child: LaptopTile(
            model: laptops.last,
            isEmployee: widget.isEmployee,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        ),
      ]);
      rows.add(row);
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: laptopBloc.laptopPageModel,
      builder: (context, AsyncSnapshot<LaptopPageModel> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sort,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      DropdownButton(
                        value: sortOrder,
                        style: TextStyle(
                          fontSize: 16.33,
                          color: Colors.black,
                        ),
                        items: sortMap.keys
                            .map<DropdownMenuItem<String>>(
                                (e) => DropdownMenuItem(
                                      child: Text(sortMap[e]),
                                      value: e,
                                    ))
                            .toList(),
                        onChanged: (String value) async {
                          setState(() {
                            sortOrder = value;
                          });
                          await laptopBloc.fetchLaptopPageModel(
                              1, sortOrder, params);
                        },
                      ),
                    ],
                  ),
                  TextButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Text(
                          'Фільтр',
                          style:
                              TextStyle(fontSize: 16.33, color: Colors.black),
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                      ],
                    ),
                    onPressed: () {
                      // TODO: implement filtering
                    },
                  ),
                ],
              ),
              NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification.metrics.pixels ==
                      scrollNotification.metrics.maxScrollExtent) {
                    setState(() {
                      // TODO: implement pagination
                    });
                    return true;
                  }
                  return false;
                },
                child: Expanded(
                  child: ListView(
                    children: buildLaptopTiles(data.laptops),
                  ),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
