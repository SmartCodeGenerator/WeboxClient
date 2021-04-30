import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PopupDialogs {
  static Future<bool> showEmployeeStatusDialog(BuildContext context) async {
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

  static Future<File> showImagePickerDialog(
      BuildContext context, String title) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        PickedFile _selectedImage;
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(
              title,
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

  static Future<bool> showConfirmDialog(
      BuildContext context, String title, String content) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          content: Text(
            content,
            style: TextStyle(
              fontSize: 18.0,
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
                  color: Colors.red,
                  fontSize: 20.0,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Підтвердити',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
