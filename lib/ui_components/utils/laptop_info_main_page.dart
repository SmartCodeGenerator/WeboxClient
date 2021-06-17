import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webox/blocs/comparison_bloc.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/config/screen_args/laptop_form_arguments.dart';
import 'package:webox/config/screen_args/laptop_info_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/repositories/order_item_repository.dart';

import 'popup_dialogs.dart';

class LaptopInfoMainPage extends StatefulWidget {
  final LaptopInfoArguments arguments;
  final LaptopModel model;
  final bool isCompared;
  final bool isPrefered;

  LaptopInfoMainPage(
      this.arguments, this.model, this.isCompared, this.isPrefered);

  @override
  _LaptopInfoMainPageState createState() => _LaptopInfoMainPageState();
}

class _LaptopInfoMainPageState extends State<LaptopInfoMainPage> {
  bool _isCompared;
  bool _isPrefered;

  @override
  void initState() {
    super.initState();
    _isCompared = widget.isCompared;
    _isPrefered = widget.isPrefered;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Image.network(
                widget.model.modelImagePath,
                height: 200,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.model.modelName,
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
                rating: widget.model.rating,
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
                    widget.model.price.toString() + ' \u{20b4}',
                    style: TextStyle(
                      color: widget.model.isAvailable
                          ? Colors.blue
                          : Colors.blueGrey,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    widget.model.isAvailable
                        ? 'Є в наявності'
                        : 'Немає в наявності',
                    style: TextStyle(
                      color:
                          widget.model.isAvailable ? Colors.green : Colors.red,
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
                        widget.model.screen.toString() + '``',
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
                        widget.model.processor,
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
                        widget.model.os,
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
                        widget.model.ram.toString() + ' ГБ',
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
                        widget.model.ssd.toString() + ' ГБ SSD',
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
                        widget.model.graphic,
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
                        widget.model.weight.toString() + ' кг',
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
                        widget.model.manufacturer,
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
                          color: _isCompared ? Colors.amber : Colors.black,
                        ),
                        onPressed: () async {
                          if (_isCompared) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            var statusCode = await comparisonBloc
                                .addComparison(widget.arguments.id);
                            if (statusCode == 200) {
                              setState(() {
                                _isCompared = true;
                              });
                              comparisonBloc.fetchComparisons();
                            } else if (statusCode == 401) {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              var snackBar = SnackBar(
                                content: Text(
                                  'Помилка при додаванні до порівнянь',
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        },
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 32.0,
                          color: _isPrefered ? Colors.red : Colors.black,
                        ),
                        onPressed: () async {
                          if (_isPrefered) {
                            Navigator.pushNamed(context, '/home');
                          } else {
                            var statusCode = await preferenceBloc
                                .addPreference(widget.arguments.id);
                            if (statusCode == 200) {
                              setState(() {
                                _isPrefered = true;
                              });
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
                        },
                      ),
                    ],
                  ),
                  FutureBuilder(
                    future: OrderItemRepository.isInCart(widget.arguments.id),
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
                            if (widget.model.isAvailable) {
                              if (!isInCart) {
                                await OrderItemRepository.insert(
                                    OrderItemModel(1, widget.arguments.id));
                              }
                              laptopBloc.refreshCatalog(
                                  widget.arguments.pageIndex,
                                  widget.arguments.sortOrder,
                                  widget.arguments.laptopQueryParams);
                              Navigator.pushNamed(
                                context,
                                '/shopping-cart',
                                arguments: {
                                  'pageIndex': widget.arguments.pageIndex,
                                  'sortOrder': widget.arguments.sortOrder,
                                  'params': widget.arguments.laptopQueryParams,
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
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              widget.arguments.isEmployee
                  ? Divider(
                      color: Colors.grey,
                    )
                  : Container(),
              widget.arguments.isEmployee
                  ? SizedBox(
                      height: 10.0,
                    )
                  : Container(),
              widget.arguments.isEmployee
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/laptops/form',
                                arguments: LaptopFormArguments(
                                    widget.arguments.id, true));
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
                                'Видалити модель ${widget.model.modelName} з переліку товарів?');
                            if (confirm) {
                              bool result = await laptopBloc
                                  .deleteLaptop(widget.arguments.id);
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
              widget.arguments.isEmployee
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
