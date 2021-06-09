import 'package:flutter/material.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/storage_lot_info_model.dart';
import 'package:webox/ui_components/utils/laptop_storage_lot.dart';

class StorageLotListScreen extends StatelessWidget {
  const StorageLotListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    storageLotBloc.fetchStorageLots();
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
            stream: storageLotBloc.storageLots,
            builder:
                (context, AsyncSnapshot<List<StorageLotInfoModel>> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Помилка при завантаженні комірок',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                var lots = snapshot.data;
                return ListView(
                  children: lots
                      .map<LaptopStorageLot>((model) =>
                          LaptopStorageLot(model, false, args))
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
