import 'package:flutter/material.dart';
import 'package:webox/blocs/deliverer_bloc.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/deliverer_info_model.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/models/storage_lot_info_model.dart';
import 'package:webox/models/storage_lot_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/utils/popup_dialogs.dart';
import 'package:webox/ui_components/utils/utility.dart';

class StorageLotInfoScreen extends StatelessWidget {
  const StorageLotInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var storageLotId = args['id'] as String;
    storageLotBloc.fetchStorageLot(storageLotId);
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: StreamBuilder(
              stream: storageLotBloc.storageLotInfo,
              builder: (context, AsyncSnapshot<StorageLotInfoModel> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error.toString());
                  return Center(
                    child: Text(
                      'Помилка при завантаженні даних комірки',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  var model = snapshot.data;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FutureBuilder(
                        future: NetworkProvider.laptopService
                            .getLaptop(model.laptopId),
                        builder: (context,
                            AsyncSnapshot<LaptopWithIdModel> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text(
                                'Помилка при завантаженні даних товару',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            var laptopModel = snapshot.data;
                            return Column(
                              children: [
                                Image.network(
                                  laptopModel.modelImagePath,
                                  height: 100.0,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                Text(
                                  laptopModel.modelName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
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
                      Divider(
                        thickness: 2.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Ідентифікатор комірки:',
                              style: TextStyle(
                                fontSize: 16.33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              model.id,
                              style: TextStyle(
                                fontSize: 16.33,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Адреса складу:',
                              style: TextStyle(
                                fontSize: 16.33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              model.warehouseAddress,
                              style: TextStyle(
                                fontSize: 16.33,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Дата поставки:',
                              style: TextStyle(
                                fontSize: 16.33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              Utility.getFormattedDateString(
                                          model.supplyDateTime) ==
                                      '1 січня 1'
                                  ? 'Не визначено'
                                  : Utility.getFormattedDateString(
                                      model.supplyDateTime),
                              style: TextStyle(
                                fontSize: 16.33,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Кількість одиниць:',
                              style: TextStyle(
                                fontSize: 16.33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              model.laptopsAmount.toString(),
                              style: TextStyle(
                                fontSize: 16.33,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              'Вартість одиниці товару:',
                              style: TextStyle(
                                fontSize: 16.33,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              model.laptopsCostPerUnit.toString() + ' \u{20b4}',
                              style: TextStyle(
                                fontSize: 16.33,
                              ),
                            ),
                          ),
                        ],
                      ),
                      FutureBuilder(
                        future: delivererBloc.getDeliverer(model.delivererId),
                        builder: (context,
                            AsyncSnapshot<DelivererInfoModel> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text(
                                'Помилка при завантаженні даних постачальника',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            var delivererModel = snapshot.data;
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Постачальник:',
                                    style: TextStyle(
                                      fontSize: 16.33,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    delivererModel.companyName != null
                                        ? delivererModel.companyName
                                        : 'відсутній',
                                    style: TextStyle(
                                      fontSize: 16.33,
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
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/storage-lots/replenish',
                              arguments: {
                                'id': args['id'],
                                'laptopId': args['laptopId'],
                                'laptopPageArgs': args['laptopPageArgs'],
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Поповнити запас',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/storage-lots/form',
                                  arguments: {
                                    'model': StorageLotModel(
                                      model.warehouseAddress,
                                      model.laptopsCostPerUnit,
                                      model.laptopId,
                                      model.delivererId,
                                    ),
                                    'update': true,
                                    'id': model.id,
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
                              bool confirm =
                                  await PopupDialogs.showConfirmDialog(
                                      context,
                                      'Видалення комірки',
                                      'Видалити дану комірку?');
                              if (confirm) {
                                var statusCode = await storageLotBloc
                                    .deleteStorageLot(storageLotId);
                                if (statusCode == 200) {
                                  storageLotBloc.fetchStorageLots();
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
                                  final snackBar = SnackBar(
                                    content:
                                        Text('Помилка при видаленні об\'єкта!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
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
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
