import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/laptop_page_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/utils/laptop_page_params.dart';
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
  List<LaptopWithIdModel> _laptops;

  @override
  void initState() {
    super.initState();
    _laptops = [];
    laptopBloc.fetchLaptopPageModel(laptopPageParams.pageIndex,
        laptopPageParams.sortOrder, laptopPageParams.laptopQueryParams);
  }

  Widget buildCatalogListView(LaptopPageModel pageModel) {
    final _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (pageModel.hasNext) {
          var page = await NetworkProvider.laptopService.getLaptopPage(
              ++laptopPageParams.pageIndex,
              laptopPageParams.sortOrder,
              laptopPageParams.laptopQueryParams);
          setState(() {
            _laptops.addAll(page.laptops);
          });
        }
      }
    });

    return Expanded(
      child: ListView(
        controller: _scrollController,
        children: buildLaptopTiles(_laptops),
      ),
    );
  }

  Row buildCatalogRow(List<Widget> children) => Row(
        children: children,
      );

  List<Widget> buildLaptopTiles(List<LaptopWithIdModel> laptops) {
    var availableLaptops = <LaptopWithIdModel>[];
    var unavailableLaptops = <LaptopWithIdModel>[];
    laptops.forEach((laptop) {
      if (laptop.isAvailable) {
        availableLaptops.add(laptop);
      } else {
        unavailableLaptops.add(laptop);
      }
    });
    laptops = [];
    laptops.addAll(availableLaptops);
    laptops.addAll(unavailableLaptops);
    List<Row> rows = [];
    for (int i = 0; i < laptops.length ~/ 2; i++) {
      var row = buildCatalogRow([
        Expanded(
          flex: 1,
          child: LaptopTile(
            laptops[2 * i],
            widget.isEmployee,
            laptopPageParams.pageIndex,
            laptopPageParams.sortOrder,
            laptopPageParams.laptopQueryParams,
            key: ObjectKey(
              laptops[2 * i],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: LaptopTile(
            laptops[(2 * i) + 1],
            widget.isEmployee,
            laptopPageParams.pageIndex,
            laptopPageParams.sortOrder,
            laptopPageParams.laptopQueryParams,
            key: ObjectKey(
              laptops[2 * i],
            ),
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
            laptops.last,
            widget.isEmployee,
            laptopPageParams.pageIndex,
            laptopPageParams.sortOrder,
            laptopPageParams.laptopQueryParams,
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
          var pageModel = snapshot.data;
          _laptops = pageModel.laptops;
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
                        value: laptopPageParams.sortOrder == null ||
                                laptopPageParams.sortOrder.isEmpty
                            ? sortMap.keys.first
                            : laptopPageParams.sortOrder,
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
                            laptopPageParams.sortOrder = value;
                          });
                          await laptopBloc.fetchLaptopPageModel(
                            1,
                            laptopPageParams.sortOrder,
                            laptopPageParams.laptopQueryParams,
                          );
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
              buildCatalogListView(pageModel),
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
