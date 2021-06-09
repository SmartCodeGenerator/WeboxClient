import 'package:flutter/material.dart';
import 'package:webox/models/deliverer_info_model.dart';
import 'package:webox/models/storage_lot_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/utils/storage_lot_form.dart';

class StorageLotFormScreen extends StatelessWidget {
  StorageLotFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var model = args['model'] as StorageLotModel;
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
          child: FutureBuilder(
            future: NetworkProvider.delivererService.getDeliverers(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                Map<String, String> options = {
                  '': '',
                };
                return StorageLotForm(
                  model,
                  options,
                  args['update'],
                  args['id'],
                );
              } else if (snapshot.hasData) {
                var deliverers = snapshot.data as List<DelivererInfoModel>;
                Map<String, String> options = {};
                options.addEntries(
                  deliverers.map<MapEntry<String, String>>((model) =>
                      MapEntry<String, String>(
                          model.companyName, model.delivererId)),
                );
                return StorageLotForm(
                  model,
                  options,
                  args['update'],
                  args['id'],
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
