import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/edit_user_info_model.dart';

class EditAccountInformationScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  EditAccountInformationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var model = ModalRoute.of(context).settings.arguments as EditUserInfoModel;
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
                Text(
                  'Редагування особистих даних',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: model.firstName,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: 'Введіть ім\'я',
                          icon: Icon(Icons.badge),
                        ),
                        validator: (firstName) {
                          return firstName == null || firstName.isEmpty
                              ? 'Поле не повинно бути порожнім'
                              : null;
                        },
                        onChanged: (firstName) {
                          model.firstName = firstName.trim();
                        },
                      ),
                      TextFormField(
                        initialValue: model.lastName,
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: 'Введіть прізвище',
                          icon: Icon(Icons.badge),
                        ),
                        validator: (lastName) {
                          return lastName == null || lastName.isEmpty
                              ? 'Поле не повинно бути порожнім'
                              : null;
                        },
                        onChanged: (lastName) {
                          model.lastName = lastName.trim();
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      var statusCode =
                          await accountBloc.editAccountInformation(model);
                      if (statusCode == 200) {
                        accountBloc.fetchUserAccount();
                        Navigator.pop(context);
                      } else if (statusCode == 401) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        final snackBar = SnackBar(
                          content: Text('Помилка при відправці!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
