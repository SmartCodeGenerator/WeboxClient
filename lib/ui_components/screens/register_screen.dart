import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as pathUtil;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isEmployee = false;
  String password = '';
  String profileImageURL;

  Future<bool> _showEmployeeStatusDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        String _authKey = '';
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'Перевірка наявності статусу працівника',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Введіть код авторизації',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _authKey = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  'Скасувати',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_authKey == '8C2t2V6zWAJiER7x') {
                    Navigator.of(context).pop(true);
                  }
                },
                child: Text(
                  'Підтвердити',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: _authKey == '8C2t2V6zWAJiER7x'
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<File> _showImagePickerDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        PickedFile _selectedImage;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              'Зображення профілю користувача',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await ImagePicker()
                              .getImage(source: ImageSource.gallery)
                              .then((value) => setState(() {
                                    _selectedImage = value;
                                  }));
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          child: _selectedImage != null
                              ? Image.file(
                                  File(_selectedImage.path),
                                  width: 120,
                                  height: 120,
                                )
                              : Icon(
                                  Icons.photo,
                                  size: 30.0,
                                ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.blueGrey[100],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedImage = null;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[350],
                        ),
                        child: Text(
                          'Очистити',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Скасувати',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (_selectedImage != null) {
                    Navigator.of(context).pop(File(_selectedImage.path));
                  }
                },
                child: Text(
                  'Підтвердити',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: _selectedImage != null ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        });
      },
    );
  }

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
              child: CustomScrollView(slivers: [
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
                              return firstname.isEmpty
                                  ? 'Поле не повинно бути порожнім'
                                  : null;
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
                              return lastname.isEmpty
                                  ? 'Поле не повинно бути порожнім'
                                  : null;
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
                          ),
                          TextFormField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              hintText: 'Введіть пароль',
                              icon: Icon(Icons.lock),
                            ),
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Поле не повинно бути порожнім';
                              } else if (value.length < 6) {
                                return 'Пароль повинний бути довжиною не менше 6 символів';
                              } else {
                                return null;
                              }
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Поле не повинно бути порожнім';
                              } else if (value != password) {
                                return 'Паролі повинні співпадати';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          TextButton(
                            onPressed: () async {
                              var profileImage = await _showImagePickerDialog();
                              setState(() {
                                // TODO: implement firebase storage saving
                                profileImageURL = profileImage != null
                                    ? pathUtil.basename(profileImage.path)
                                    : null;
                              });
                            },
                            child: Text(
                              'Завантажити зображення профілю',
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                          profileImageURL != null && profileImageURL.isNotEmpty
                              ? Text(
                                  'Завантажено файл: $profileImageURL',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.green,
                                  ),
                                )
                              : Container(),
                          Row(
                            children: [
                              Checkbox(
                                value: _isEmployee,
                                onChanged: (value) async {
                                  if (value) {
                                    bool result =
                                        await _showEmployeeStatusDialog();
                                    setState(() {
                                      _isEmployee =
                                          result != null ? result : false;
                                    });
                                  } else {
                                    setState(() {
                                      _isEmployee = value;
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
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              // TODO: implement registration service
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'ЗАРЕЄСТРУВАТИСЯ',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
