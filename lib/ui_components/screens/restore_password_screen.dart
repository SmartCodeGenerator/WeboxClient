import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';

class RestorePasswordScreen extends StatefulWidget {
  RestorePasswordScreen({Key key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<RestorePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  String userEmail = '';
  TextEditingController emailFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 36.0,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Відновлення втраченого пароля',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Введіть електронну пошту',
                    icon: Icon(Icons.email),
                  ),
                  controller: emailFieldController,
                  validator: (email) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(email)
                        ? null
                        : 'Неправильний формат електронної пошти';
                  },
                  onChanged: (email) {
                    userEmail = email.trim();
                  },
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      int statusCode =
                          await accountBloc.restorePassword(userEmail);
                      if (statusCode == 200) {
                        Navigator.pop(context);
                      } else {
                        emailFieldController.clear();
                        final snackBar = SnackBar(
                          content: Text('Помилка при відправці!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'ВІДПРАВИТИ',
                      style: TextStyle(fontSize: 20.0),
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
