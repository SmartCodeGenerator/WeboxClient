import 'package:flutter/material.dart';
import 'package:webox/models/storage_lot_model.dart';
import 'package:webox/ui_components/utils/laptop_storage_lot.dart';

class LaptopStorageLots extends StatelessWidget {
  final Map<String, dynamic> args;
  const LaptopStorageLots(this.args, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(args['storageLots']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ListView(
            children: args['storageLots']
                .map<LaptopStorageLot>((model) =>
                    LaptopStorageLot(model, true, args['laptopPageArgs']))
                .toList(),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/storage-lots/form', arguments: {
              'model': StorageLotModel('', 0.0, args['laptopId'], ''),
              'update': false,
              'id': null,
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'ДОДАТИ КОМІРКУ',
              style: TextStyle(
                fontSize: 16.33,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
