import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as pathUtil;
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/register_model.dart';
import 'package:webox/ui_components/utils/popup_dialogs.dart';
import 'package:webox/ui_components/utils/utility.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  RegisterModel model = RegisterModel();
  File profileImage;
  String profileImageURL;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/add_user.png',
                          fit: BoxFit.cover,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                hintText: 'Введіть ім\'я',
                                icon: Icon(Icons.badge),
                              ),
                              validator: (firstname) {
                                return firstname == null || firstname.isEmpty
                                    ? 'Поле не повинно бути порожнім'
                                    : null;
                              },
                              onChanged: (firstName) {
                                model.firstName = firstName.trim();
                              },
                            ),
                            TextFormField(
                              keyboardType: TextInputType.text,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                hintText: 'Введіть прізвище',
                                icon: Icon(Icons.badge),
                              ),
                              validator: (lastname) {
                                return lastname == null || lastname.isEmpty
                                    ? 'Поле не повинно бути порожнім'
                                    : null;
                              },
                              onChanged: (lastName) {
                                model.lastName = lastName.trim();
                              },
                            ),
                            TextFormField(
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
                                model.email = email.trim();
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                hintText: 'Введіть пароль',
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
                                model.password = password;
                              },
                            ),
                            TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(fontSize: 18.0),
                              decoration: InputDecoration(
                                hintText: 'Повторіть пароль',
                                icon: Icon(Icons.lock_outline),
                              ),
                              validator: (confirmPassword) {
                                if (confirmPassword == null ||
                                    confirmPassword.isEmpty) {
                                  return 'Поле не повинно бути порожнім';
                                } else if (confirmPassword != model.password) {
                                  return 'Паролі повинні співпадати';
                                }
                                return null;
                              },
                              onChanged: (confirmPassword) {
                                model.confirmPassword = confirmPassword;
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextButton(
                              onPressed: () async {
                                var selectedFile =
                                    await PopupDialogs.showImagePickerDialog(
                                        context,
                                        'Зображення профілю користувача');
                                if (selectedFile != null) {
                                  profileImage = selectedFile;
                                }
                                if (profileImage != null) {
                                  setState(() {
                                    profileImageURL =
                                        pathUtil.basename(profileImage.path);
                                  });
                                }
                              },
                              child: Text(
                                'Завантажити зображення профілю',
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            profileImageURL != null &&
                                    profileImageURL.isNotEmpty
                                ? Text(
                                    'Завантажено файл: $profileImageURL',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.deepPurple,
                                    ),
                                  )
                                : Container(),
                            Row(
                              children: [
                                Checkbox(
                                  value: model.isEmployee,
                                  onChanged: (value) async {
                                    if (value) {
                                      bool result = await PopupDialogs
                                          .showEmployeeStatusDialog(context);
                                      setState(() {
                                        model.isEmployee =
                                            result != null ? result : false;
                                      });
                                    } else {
                                      setState(() {
                                        model.isEmployee = value;
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  'Я є працівником фірми "Webox"',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                if (profileImage != null) {
                                  var downloadURL = await Utility.uploadFile(
                                      profileImage, 'profiles');
                                  model.profileImagePath = downloadURL;
                                }
                                try {
                                  await accountBloc.register(model);
                                  Navigator.pushNamed(context, '/home');
                                } catch (ex) {
                                  print(ex);
                                  final snackBar = SnackBar(
                                    content: Text('Помилка реєстрації!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'ЗАРЕЄСТРУВАТИСЯ',
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
