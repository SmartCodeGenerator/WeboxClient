import 'package:flutter/material.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/services/network_provider.dart';

class OrderItemTile extends StatelessWidget {
  final OrderItemModel model;
  const OrderItemTile(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: NetworkProvider.laptopService.getLaptop(model.laptopId),
      builder: (context, AsyncSnapshot<LaptopWithIdModel> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Container();
        } else if (snapshot.hasData) {
          var laptopModel = snapshot.data;
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  laptopModel.modelImagePath,
                  height: 40.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    laptopModel.modelName,
                    style: TextStyle(
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  model.amount.toString() + ' шт.',
                  style: TextStyle(
                    fontSize: 16.33,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
