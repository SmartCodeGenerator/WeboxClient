import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';

class LaptopSearchScreen extends StatelessWidget {
  final searchController = TextEditingController();
  LaptopSearchScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    String sortOrder = args['sortOrder'];
    LaptopQueryParams params = args['params'];
    searchController.text = params.modelName;
    laptopBloc.fetchSearchOptions(params.modelName);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          keyboardType: TextInputType.text,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Введіть назву моделі...',
            suffix: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                searchController.clear();
                params.modelName = '';
                laptopBloc.fetchSearchOptions('');
                laptopBloc.fetchLaptopPageModel(1, sortOrder, params);
              },
            ),
          ),
          onChanged: (value) {
            params.modelName = value;
            laptopBloc.fetchSearchOptions(value);
            laptopBloc.fetchLaptopPageModel(1, sortOrder, params);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: laptopBloc.searchOptions,
            builder: (context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Помилка при завантаженні назв моделей ноутбуків',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                var options = snapshot.data;
                options.sort((option1, option2) => option1.compareTo(option2));
                return ListView(
                  children: options
                      .map<Widget>((option) => ListTile(
                            title: Text(
                              option,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              searchController.text = option;
                              params.modelName = option;
                              laptopBloc.fetchSearchOptions(option);
                              laptopBloc.fetchLaptopPageModel(
                                  1, sortOrder, params);
                            },
                          ))
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
