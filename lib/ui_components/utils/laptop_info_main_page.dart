import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/config/screen_args/laptop_form_arguments.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/repositories/order_item_repository.dart';

import 'popup_dialogs.dart';

class LaptopInfoMainPage extends StatelessWidget {
  final LaptopInfoArguments arguments;
  final LaptopModel model;

  LaptopInfoMainPage(this.arguments, this.model);

  @override
  Widget build(BuildContext context) {
    preferenceBloc.fetchPreferenceStatus(arguments.id);
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Image.network(
                model.modelImagePath,
                height: 200,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                model.modelName,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                rating: model.rating,
                itemCount: 5,
                direction: Axis.horizontal,
                itemSize: 35.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    model.price.toString() + ' \u{20b4}',
                    style: TextStyle(
                      color: model.isAvailable ? Colors.blue : Colors.blueGrey,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    model.isAvailable ? 'Є в наявності' : 'Немає в наявності',
                    style: TextStyle(
                      color: model.isAvailable ? Colors.green : Colors.red,
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.grey,
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Діагональ екрана',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.screen.toString() + '``',
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Процесор',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.processor,
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Операційна система',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.os,
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Обсяг оперативної пам\'яті',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.ram.toString() + ' ГБ',
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Обсяг накопичувача',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.ssd.toString() + ' ГБ SSD',
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Відеокарта',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.graphic,
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Вага',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.weight.toString() + ' кг',
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.0),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Виробник',
                        style: TextStyle(
                          fontSize: 16.33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 36.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        model.manufacturer,
                        style: TextStyle(
                          fontSize: 16.33,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.compare_outlined,
                          size: 32.0,
                        ),
                        onPressed: () {
                          // TODO: implement add to comparison
                        },
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      StreamBuilder(
                        stream: preferenceBloc.preferenceStatus,
                        builder: (context,
                            AsyncSnapshot<Map<String, dynamic>> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return IconButton(
                              icon: Icon(
                                Icons.favorite,
                                size: 32.0,
                              ),
                              onPressed: () {},
                            );
                          } else if (snapshot.hasData) {
                            var status = snapshot.data;
                            return IconButton(
                              icon: Icon(
                                Icons.favorite,
                                size: 32.0,
                                color: status['id'] == arguments.id &&
                                        status['result']
                                    ? Colors.red
                                    : Colors.black,
                              ),
                              onPressed: () async {
                                if (status['id'] == arguments.id) {
                                  if (status['result']) {
                                    Navigator.pushNamed(context, '/home');
                                  } else {
                                    var statusCode = await preferenceBloc
                                        .addPreference(arguments.id);
                                    if (statusCode == 200) {
                                      preferenceBloc
                                          .fetchPreferenceStatus(arguments.id);
                                      preferenceBloc.fetchPreferences();
                                    } else if (statusCode == 401) {
                                      Navigator.pushNamed(context, '/login');
                                    } else {
                                      var snackBar = SnackBar(
                                        content: Text(
                                          'Помилка при додаванні до вподобань',
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  }
                                }
                              },
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: OrderItemRepository.isInCart(arguments.id),
                    builder: (context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error.toString());
                        return ElevatedButton(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48.0,
                              vertical: 8.0,
                            ),
                            child: Icon(
                              Icons.add_shopping_cart,
                              size: 32.0,
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        var isInCart = snapshot.data;
                        return ElevatedButton(
                          onPressed: () async {
                            if (model.isAvailable) {
                              if (!isInCart) {
                                await OrderItemRepository.insert(
                                    OrderItemModel(1, arguments.id));
                              }
                              laptopBloc.refreshCatalog(
                                  arguments.pageIndex,
                                  arguments.sortOrder,
                                  arguments.laptopQueryParams);
                              Navigator.pushNamed(
                                context,
                                '/shopping-cart',
                                arguments: {
                                  'pageIndex': arguments.pageIndex,
                                  'sortOrder': arguments.sortOrder,
                                  'params': arguments.laptopQueryParams,
                                },
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48.0,
                              vertical: 8.0,
                            ),
                            child: Icon(
                              isInCart
                                  ? Icons.shopping_cart
                                  : Icons.add_shopping_cart,
                              size: 32.0,
                            ),
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48.0,
                            vertical: 8.0,
                          ),
                          child: Icon(
                            Icons.add_shopping_cart,
                            size: 32.0,
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              arguments.isEmployee
                  ? Divider(
                      color: Colors.grey,
                    )
                  : Container(),
              arguments.isEmployee
                  ? SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              arguments.isEmployee
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/laptops/form',
                                arguments:
                                    LaptopFormArguments(arguments.id, true));
                          },
                          child: Text(
                            'Редагувати',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            bool confirm = await PopupDialogs.showConfirmDialog(
                                context,
                                'Видалення моделі',
                                'Видалити модель ${model.modelName} з переліку товарів?');
                            if (confirm) {
                              bool result =
                                  await laptopBloc.deleteLaptop(arguments.id);
                              if (result) {
                                Navigator.pushNamed(context, '/home');
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
                              fontSize: 20.0,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
              arguments.isEmployee
                  ? SizedBox(
                      height: 10.0,
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
