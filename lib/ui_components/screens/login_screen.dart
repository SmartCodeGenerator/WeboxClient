import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/login_model.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final model = LoginModel();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset('assets/images/webox_logo.png'),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Введіть електронну пошту',
                              icon: Icon(Icons.email)),
                          style: TextStyle(fontSize: 18.0),
                          validator: (email) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email)
                                ? null
                                : 'Неправильний формат електронної пошти';
                          },
                          onChanged: (value) {
                            model.email = value.trim();
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Введіть пароль',
                            icon: Icon(Icons.lock),
                          ),
                          style: TextStyle(fontSize: 18.0),
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Поле не повинно бути порожнім';
                            } else if (password.length < 6) {
                              return 'Пароль повинний бути довжиною не менше 6 символів';
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            model.password = value;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              try {
                                await accountBloc.login(model);
                                Navigator.pushNamed(context, '/home');
                              } catch (ex) {
                                print(ex);
                                passwordController.clear();
                                final snackBar = SnackBar(
                                  content: Text('Помилка аутентифікації!'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'ВВІЙТИ',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/password/restore');
                          },
                          child: Text(
                            'Забули пароль?',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Не маєте власного облікового запису?',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: Text(
                        'Зареєструватися',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
