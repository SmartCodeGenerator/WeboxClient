import 'package:flutter/material.dart';
import 'package:webox/blocs/order_bloc.dart';
import 'package:webox/models/order_info_model.dart';
import 'package:webox/ui_components/utils/order_info_card.dart';

class OrdersListScreen extends StatelessWidget {
  const OrdersListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    orderBloc.fetchOrders();
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
            stream: orderBloc.orders,
            builder: (context, AsyncSnapshot<List<OrderInfoModel>> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Помилка при завантаженні замовлень',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                var orders = snapshot.data;
                orders.sort((order1, order2) => order2.placementDateTime
                    .compareTo(order1.placementDateTime));
                return ListView(
                  children: orders
                      .map<OrderInfoCard>((model) => OrderInfoCard(
                            model,
                            args,
                            key: ObjectKey(model),
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
