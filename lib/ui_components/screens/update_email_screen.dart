import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';

class UpdateEmailScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  UpdateEmailScreen({Key key}) : super(key: key);

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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  args['title'],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: TextFormField(
                    initialValue: args['email'],
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      hintText: 'Введіть електронну пошту',
                      icon: Icon(Icons.email),
                    ),
                    validator: (email) {
                      return RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)
                          ? null
                          : 'Неправильний формат електронної пошти';
                    },
                    onChanged: (email) {
                      args['email'] = email.trim();
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState.validate()) {
                      var statusCode =
                          await accountBloc.updateEmail(args['email']);
                      if (statusCode == 200) {
                        Navigator.pushNamed(context, '/login');
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
