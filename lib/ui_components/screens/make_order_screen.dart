import 'package:flutter/material.dart';
import 'package:webox/models/order_model.dart';
import 'package:webox/ui_components/utils/order_item_tile.dart';

class MakeOrderScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  MakeOrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var model = args['model'] as OrderModel;
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
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Введіть адресу доставки',
                      icon: Icon(
                        Icons.location_pin,
                      ),
                    ),
                    validator: (deliveryAddress) {
                      return deliveryAddress == null ||
                              deliveryAddress.trim().isEmpty
                          ? 'Поле не повинно бути порожнім'
                          : null;
                    },
                    onChanged: (deliveryAddress) {
                      model.deliveryAddress = deliveryAddress.trim();
                    },
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Перелік обраних товарів',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Expanded(
                  child: ListView(
                    children: model.orderItems
                        .map<OrderItemTile>(
                          (item) => OrderItemTile(
                            item,
                            key: ObjectKey(item),
                          ),
                        )
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
                      model.price.toString() + ' \u{20b4}',
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
                    if (formKey.currentState.validate()) {
                      Navigator.pushNamed(
                        context,
                        '/card-payment',
                        arguments: {
                          'model': model,
                          'pageIndex': args['pageIndex'],
                          'sortOrder': args['sortOrder'],
                          'params': args['params'],
                        },
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Перейти до сплати',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
