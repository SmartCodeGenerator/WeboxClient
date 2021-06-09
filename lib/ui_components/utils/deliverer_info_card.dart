import 'package:flutter/material.dart';
import 'package:webox/blocs/deliverer_bloc.dart';
import 'package:webox/models/deliverer_info_model.dart';
import 'package:webox/models/deliverer_model.dart';

import 'popup_dialogs.dart';

class DelivererInfoCard extends StatelessWidget {
  final DelivererInfoModel model;
  const DelivererInfoCard(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.business,
                size: 30.0,
              ),
              title: Text(
                model.companyName,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                size: 30.0,
              ),
              title: Text(
                model.phoneNumber,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.location_on,
                size: 30.0,
              ),
              title: Text(
                model.mainOfficeAddress,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/deliverer/form', arguments: {
                      'data': DelivererModel(model.companyName,
                          model.phoneNumber, model.mainOfficeAddress),
                      'isForUpdate': true,
                      'id': model.delivererId,
                    });
                  },
                  child: Text(
                    'Редагувати',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    bool confirm = await PopupDialogs.showConfirmDialog(
                        context,
                        'Видалення постачальника',
                        'Видалити даного постачальника?');
                    if (confirm) {
                      var statusCode = await delivererBloc
                          .deleteDeliverer(model.delivererId);
                      if (statusCode == 200) {
                        delivererBloc.fetchDeliverers();
                      } else if (statusCode == 401) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Помилка при видаленні об\'єкта!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text(
                    'Видалити',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
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
