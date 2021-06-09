import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/reset_password_model.dart';

class ResetPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  ResetPasswordScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments as ResetPasswordModel;
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Скидання пароля облікового запису',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: 'Введіть новий пароль',
                          icon: Icon(Icons.lock),
                        ),
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return 'Поле не повинно бути порожнім';
                          } else if (password.length < 6) {
                            return 'Пароль повинний бути довжиною не менше 6 символів';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (password) {
                          args.newPassword = password;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 18.0),
                        decoration: InputDecoration(
                          hintText: 'Повторіть новий пароль',
                          icon: Icon(Icons.lock_outline),
                        ),
                        validator: (confirmPassword) {
                          if (confirmPassword == null ||
                              confirmPassword.isEmpty) {
                            return 'Поле не повинно бути порожнім';
                          } else if (confirmPassword != args.newPassword) {
                            return 'Паролі повинні співпадати';
                          }
                          return null;
                        },
                        onChanged: (confirmPassword) {
                          args.confirmNewPassword = confirmPassword;
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      var statusCode = await accountBloc.resetPassword(args);
                      if (statusCode == 200) {
                        int counter = 0;
                        Navigator.of(context)
                            .popUntil((route) => counter++ >= 2);
                      } else if (statusCode == 401) {
                        Navigator.pushNamed(context, '/login');
                      } else {
                        var snackBar = SnackBar(
                          content: Text('Помилка при відправці'),
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
