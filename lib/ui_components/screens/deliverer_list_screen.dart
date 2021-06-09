import 'package:flutter/material.dart';
import 'package:webox/blocs/deliverer_bloc.dart';
import 'package:webox/models/deliverer_info_model.dart';
import 'package:webox/models/deliverer_model.dart';
import 'package:webox/ui_components/utils/deliverer_info_card.dart';

class DelivererListScreen extends StatelessWidget {
  const DelivererListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    delivererBloc.fetchDeliverers();
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
            stream: delivererBloc.deliverers,
            builder:
                (context, AsyncSnapshot<List<DelivererInfoModel>> snapshot) {
              if (snapshot.hasData) {
                var deliverers = snapshot.data;
                return ListView(
                  children: deliverers
                      .map<DelivererInfoCard>(
                        (model) => DelivererInfoCard(
                          model,
                          key: ObjectKey(model),
                        ),
                      )
                      .toList(),
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text(
                    'Виникла помилка при завантаженні',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/deliverer/form', arguments: {
            'data': DelivererModel('', '', ''),
            'isForUpdate': false,
            'id': null,
          });
        },
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
    );
  }
}
