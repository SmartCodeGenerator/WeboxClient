import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/blocs/comparison_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/comparison_model.dart';

class ComparePage extends StatelessWidget {
  final List<ComparisonModel> models;
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;
  const ComparePage(this.models, this.isEmployee, this.pageIndex,
      this.sortOrder, this.laptopQueryParams,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/laptops/info',
                      arguments: LaptopInfoArguments(
                        models[0].laptopModel.id,
                        isEmployee,
                        pageIndex,
                        sortOrder,
                        laptopQueryParams,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              var statusCode = await comparisonBloc
                                  .removeComparison(models[0].id);
                              if (statusCode == 200) {
                                comparisonBloc.fetchComparisons();
                              } else if (statusCode == 401) {
                                Navigator.pushNamed(context, '/login');
                              } else {
                                var snackBar = SnackBar(
                                  content:
                                      Text('Помилка при видаленні об\'єкта'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        ],
                      ),
                      Image.network(
                        models[0].laptopModel.modelImagePath,
                        height: 80.0,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      SizedBox(
                        height: 40.0,
                        child: Text(
                          models[0].laptopModel.modelName,
                          style: TextStyle(
                            fontSize: 16.33,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                thickness: 2.0,
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/laptops/info',
                      arguments: LaptopInfoArguments(
                        models[1].laptopModel.id,
                        isEmployee,
                        pageIndex,
                        sortOrder,
                        laptopQueryParams,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30.0,
                            ),
                            onPressed: () async {
                              var statusCode = await comparisonBloc
                                  .removeComparison(models[1].id);
                              if (statusCode == 200) {
                                comparisonBloc.fetchComparisons();
                              } else if (statusCode == 401) {
                                Navigator.pushNamed(context, '/login');
                              } else {
                                var snackBar = SnackBar(
                                  content:
                                      Text('Помилка при видаленні об\'єкта'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        ],
                      ),
                      Image.network(
                        models[1].laptopModel.modelImagePath,
                        height: 80.0,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      SizedBox(
                        height: 40.0,
                        child: Text(
                          models[1].laptopModel.modelName,
                          style: TextStyle(
                            fontSize: 16.33,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Виробник',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.manufacturer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.manufacturer,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Процесор',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.processor,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.processor,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Відеокарта',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.graphic,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.graphic,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Обсяг оперативної пам\'яті',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.ram.toString() + ' ГБ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.ram.toString() + ' ГБ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Обсяг накопичувача',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.ssd.toString() + ' ГБ SSD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.ssd.toString() + ' ГБ SSD',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Діагональ екрана',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.screen.toString() + '``',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.screen.toString() + '``',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Операційна система',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.os,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.os,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Вага',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.weight.toString() + ' кг',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.weight.toString() + ' кг',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Ціна',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[0].laptopModel.price.toString() + ' \u{20b4}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Text(
                          models[1].laptopModel.price.toString() + ' \u{20b4}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                color: Colors.grey[200],
                child: Text(
                  'Рейтинг',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Center(
                          child: RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            rating: models[0].laptopModel.rating,
                            itemSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      thickness: 2.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.0,
                        ),
                        child: Center(
                          child: RatingBarIndicator(
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            rating: models[1].laptopModel.rating,
                            itemSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
