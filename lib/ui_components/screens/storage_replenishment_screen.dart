import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/storage_replenishment_model.dart';

class StorageReplenishmentScreen extends StatefulWidget {
  StorageReplenishmentScreen({Key key}) : super(key: key);

  @override
  _StorageReplenishmentScreenState createState() =>
      _StorageReplenishmentScreenState();
}

class _StorageReplenishmentScreenState
    extends State<StorageReplenishmentScreen> {
  double laptopAmount;

  @override
  void initState() {
    super.initState();
    laptopAmount = 50;
  }

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Поповнення комірки ${args['id']}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Slider(
                    value: laptopAmount,
                    min: 1,
                    max: 100,
                    onChanged: (value) {
                      setState(() {
                        laptopAmount = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Кількість одиниць:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        laptopAmount.round().toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  final model = StorageReplenishmentModel(laptopAmount.round());
                  var statusCode = await storageLotBloc.replenishStorageLot(
                      args['id'], model);
                  if (statusCode == 200) {
                    storageLotBloc.fetchStorageLots();
                    storageLotBloc.fetchStorageLot(args['id']);
                    laptopBloc.fetchLaptopModel(args['laptopId']);
                    laptopBloc.refreshCatalog(
                      args['laptopPageArgs']['pageIndex'],
                      args['laptopPageArgs']['sortOrder'],
                      args['laptopPageArgs']['queryParams'],
                    );
                    Navigator.of(context).pop();
                  } else if (statusCode == 401) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    var snackBar = SnackBar(
                      content: Text('Помилка при відправці'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6.0,
                    horizontal: 24.0,
                  ),
                  child: Text(
                    'ВІДПРАВИТИ',
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
    );
  }
}
