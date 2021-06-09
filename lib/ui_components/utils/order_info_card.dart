import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/order_bloc.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/order_info_model.dart';
import 'package:webox/ui_components/utils/order_item_tile.dart';
import 'package:webox/ui_components/utils/popup_dialogs.dart';
import 'package:webox/ui_components/utils/utility.dart';

class OrderInfoCard extends StatefulWidget {
  final OrderInfoModel model;
  final Map<String, dynamic> args;
  const OrderInfoCard(this.model, this.args, {Key key}) : super(key: key);

  @override
  _OrderInfoCardState createState() => _OrderInfoCardState();
}

class _OrderInfoCardState extends State<OrderInfoCard> {
  OrderInfoModel _model;
  Map<String, dynamic> _args;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Utility.getFormattedDateString(_model.placementDateTime),
                  style: TextStyle(
                    fontSize: 16.33,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Ідентифікатор:',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    _model.id,
                    style: TextStyle(
                      fontSize: 16.33,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Адреса доставки:',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    _model.deliveryAddress,
                    style: TextStyle(
                      fontSize: 16.33,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Дата прибуття:',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    Utility.getFormattedDateString(_model.deliveryDateTime),
                    style: TextStyle(
                      fontSize: 16.33,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    'Вартість:',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    _model.price.toString() + ' \u{20b4}',
                    style: TextStyle(
                      fontSize: 16.33,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            ExpansionTile(
              title: Text(
                'Придбані товари',
                style: TextStyle(
                  fontSize: 16.33,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: _model.orderItems
                  .map<OrderItemTile>(
                    (item) => OrderItemTile(
                      item,
                      key: ObjectKey(item),
                    ),
                  )
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var result = await PopupDialogs.showConfirmDialog(context,
                        'Скасування замовлення', 'Скасувати дане замовлення?');
                    if (result) {
                      var statusCode = await orderBloc.cancelOrder(_model.id);
                      if (statusCode == 200) {
                        orderBloc.fetchOrders();
                        storageLotBloc.fetchStorageLots();
                        laptopBloc.refreshCatalog(_args['pageIndex'],
                            _args['sortOrder'], _args['params']);
                      } else if (statusCode == 401) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        var snackBar = SnackBar(
                          content: Text(
                            'Помилка при видаленні об\'єкта',
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: Text(
                      'Скасувати',
                      style: TextStyle(
                        fontSize: 16.33,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
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
