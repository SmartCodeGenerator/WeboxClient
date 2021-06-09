import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/order_item_bloc.dart';
import 'package:webox/blocs/preference_bloc.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/order_item_model.dart';
import 'package:webox/repositories/order_item_repository.dart';

class OrderItemCard extends StatefulWidget {
  final LaptopWithIdModel model;
  final int maxAmount;
  final int amount;
  final Map<String, dynamic> args;
  const OrderItemCard(this.model, this.maxAmount, this.amount, this.args,
      {Key key})
      : super(key: key);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  LaptopWithIdModel _model;
  int _currentAmount;
  int _limit;
  Map<String, dynamic> _args;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    _currentAmount =
        widget.amount > widget.maxAmount ? widget.maxAmount : widget.amount;
    _limit = widget.maxAmount;
    _args = widget.args;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  _model.modelImagePath,
                  height: 50.0,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    _model.modelName,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  iconSize: 30.0,
                  onPressed: () async {
                    await orderItemBloc.removeOrderItem(_model.id);
                    await laptopBloc.fetchLaptopModel(_model.id);
                    await laptopBloc.refreshCatalog(
                      _args['pageIndex'],
                      _args['sortOrder'],
                      _args['params'],
                    );
                    await preferenceBloc.fetchPreferences();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      color: _currentAmount == 1 ? Colors.grey : Colors.blue,
                      iconSize: 30.0,
                      onPressed: () async {
                        if (_currentAmount > 1) {
                          setState(() {
                            _currentAmount--;
                          });
                          await OrderItemRepository.update(
                              OrderItemModel(_currentAmount, _model.id));
                          await orderItemBloc.fetchOrderItems();
                        }
                      },
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      _currentAmount.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      color: _currentAmount == _limit || _currentAmount == 100
                          ? Colors.grey
                          : Colors.blue,
                      iconSize: 30.0,
                      onPressed: () async {
                        if (_currentAmount < _limit && _currentAmount < 100) {
                          setState(() {
                            _currentAmount++;
                          });
                          await OrderItemRepository.update(
                              OrderItemModel(_currentAmount, _model.id));
                          await orderItemBloc.fetchOrderItems();
                        }
                      },
                    ),
                  ],
                ),
                Text(
                  (_currentAmount * _model.price).toString() + ' \u{20b4}',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
