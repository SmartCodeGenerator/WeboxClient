import 'package:flutter/material.dart';
import 'package:webox/blocs/deliverer_bloc.dart';
import 'package:webox/models/deliverer_model.dart';

class DelivererFormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  DelivererFormScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var model = args['data'] as DelivererModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Webox'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: model.companyName,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Введіть назву компанії',
                          icon: Icon(
                            Icons.business,
                          ),
                        ),
                        validator: (companyName) {
                          return companyName == null ||
                                  companyName.trim().isEmpty
                              ? 'Поле не повинно бути порожнім'
                              : null;
                        },
                        onChanged: (companyName) {
                          model.companyName = companyName.trim();
                        },
                      ),
                      TextFormField(
                        initialValue: model.phoneNumber,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Введіть номер телефона',
                          icon: Icon(
                            Icons.phone,
                          ),
                        ),
                        validator: (phoneNumber) {
                          return RegExp(r"^(?:[+0][1-9])?[0-9]{10,12}$")
                                  .hasMatch(phoneNumber)
                              ? null
                              : 'Неправильний формат номера телефона';
                        },
                        onChanged: (phoneNumber) {
                          model.phoneNumber = phoneNumber.trim();
                        },
                      ),
                      TextFormField(
                        initialValue: model.mainOfficeAddress,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Введіть адресу головного офісу',
                          icon: Icon(Icons.location_on),
                        ),
                        validator: (mainOfficeAddress) {
                          return mainOfficeAddress == null ||
                                  mainOfficeAddress.trim().isEmpty
                              ? 'Поле не повинно бути порожнім'
                              : null;
                        },
                        onChanged: (mainOfficeAddress) {
                          model.mainOfficeAddress = mainOfficeAddress.trim();
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      {
                        var statusCode = !args['isForUpdate']
                            ? await delivererBloc.saveDeliverer(model)
                            : await delivererBloc.updateDeliverer(
                                args['id'], model);
                        if (statusCode == 200) {
                          delivererBloc.fetchDeliverers();
                          Navigator.of(context).pop();
                        } else if (statusCode == 401) {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          var snackBar = SnackBar(
                            content: Text('Помилка при відправці'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
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
      ),
    );
  }
}
