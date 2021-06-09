import 'package:flutter/material.dart';
import 'package:webox/blocs/order_item_bloc.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/models/order_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/utils/order_item_card.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    orderItemBloc.fetchOrderItems();
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
            stream: orderItemBloc.orderItems,
            builder: (context, AsyncSnapshot<List<OrderItemModel>> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Помилка при завантаженні доданих в кошик товарів',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                var orderItems = snapshot.data;
                return Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: orderItems
                            .map((orderItem) => FutureBuilder(
                                  future: NetworkProvider.laptopService
                                      .getLaptop(orderItem.laptopId),
                                  builder: (context,
                                      AsyncSnapshot<LaptopWithIdModel>
                                          snapshot) {
                                    if (snapshot.hasError) {
                                      print(snapshot.error.toString());
                                      return Container();
                                    } else if (snapshot.hasData) {
                                      var laptopModel = snapshot.data;
                                      return FutureBuilder(
                                        future: storageLotBloc.getLaptopAmount(
                                            orderItem.laptopId),
                                        builder: (context,
                                            AsyncSnapshot<dynamic> snapshot2) {
                                          if (snapshot2.hasError) {
                                            print(snapshot2.error.toString());
                                            return Container();
                                          } else if (snapshot2.hasData) {
                                            var result = snapshot2.data;
                                            if (result is int) {
                                              int totalLaptopAmount = result;
                                              return OrderItemCard(
                                                laptopModel,
                                                totalLaptopAmount,
                                                orderItem.amount,
                                                args,
                                                key: ObjectKey(laptopModel),
                                              );
                                            } else {
                                              return Container();
                                            }
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
                                ))
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Загальна вартість:',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          orderItemBloc.totalPrice.toString() + ' \u{20b4}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/make-order',
                          arguments: {
                            'model': OrderModel(
                              '',
                              orderItemBloc.totalPrice,
                              orderItems,
                            ),
                            'pageIndex': args['pageIndex'],
                            'sortOrder': args['sortOrder'],
                            'params': args['params'],
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Оформити замовлення',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
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
