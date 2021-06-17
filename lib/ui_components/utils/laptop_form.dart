import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/config/screen_args/laptop_form_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:path/path.dart' as pathUtil;
import 'package:webox/ui_components/utils/utility.dart';

import 'popup_dialogs.dart';

class LaptopForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final LaptopModel model;
  final LaptopFormArguments arguments;

  LaptopForm({this.formKey, this.model, this.arguments});

  @override
  _LaptopFormState createState() => _LaptopFormState();
}

class _LaptopFormState extends State<LaptopForm> {
  File laptopImage;
  String laptopModelImageURL = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.model.modelName,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть назву моделі',
              icon: Icon(
                Icons.laptop_chromebook,
              ),
            ),
            validator: (modelName) {
              return modelName == null || modelName.trim().isEmpty
                  ? 'Поле не повинно бути порожнім'
                  : null;
            },
            onChanged: (modelName) {
              widget.model.modelName = modelName.trim();
            },
          ),
          TextFormField(
            initialValue: widget.model.manufacturer,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть виробника моделі',
              icon: Icon(
                Icons.precision_manufacturing_outlined,
              ),
            ),
            validator: (manufacturer) {
              return manufacturer == null || manufacturer.trim().isEmpty
                  ? 'Поле не повинно бути порожнім'
                  : null;
            },
            onChanged: (manufacturer) {
              widget.model.manufacturer = manufacturer.trim();
            },
          ),
          TextFormField(
            initialValue: widget.model.processor,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть назву процесору моделі',
              icon: Icon(
                Icons.calculate,
              ),
            ),
            validator: (processor) {
              return processor == null || processor.trim().isEmpty
                  ? 'Поле не повинно бути порожнім'
                  : null;
            },
            onChanged: (processor) {
              widget.model.processor = processor.trim();
            },
          ),
          TextFormField(
            initialValue: widget.model.graphic,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть назву відеокарти моделі',
              icon: Icon(
                Icons.videogame_asset,
              ),
            ),
            validator: (graphic) {
              return graphic == null || graphic.trim().isEmpty
                  ? 'Поле не повинно бути порожнім'
                  : null;
            },
            onChanged: (graphic) {
              widget.model.graphic = graphic.trim();
            },
          ),
          TextFormField(
            initialValue: widget.model.ram.toString(),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть обсяг ОЗУ моделі в GB',
              icon: Icon(
                Icons.memory,
              ),
            ),
            validator: (ram) {
              if (ram == null || ram.trim().isEmpty) {
                return 'Поле не повинно бути порожнім';
              } else if (int.tryParse(ram) == null) {
                return 'Необхідно ввести числове значення';
              } else if (int.parse(ram) < 0) {
                return 'Число повинно бути не менше 0';
              } else if (int.parse(ram) > 128) {
                return 'Число повинно бути не більше 128';
              }
              return null;
            },
            onChanged: (ram) {
              try {
                widget.model.ram = int.tryParse(ram.trim());
              } catch (ex) {
                print(ex);
              }
            },
          ),
          TextFormField(
            initialValue: widget.model.ssd.toString(),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть обсяг SSD моделі в GB',
              icon: Icon(
                Icons.storage,
              ),
            ),
            validator: (ssd) {
              if (ssd == null || ssd.trim().isEmpty) {
                return 'Поле не повинно бути порожнім';
              } else if (int.tryParse(ssd) == null) {
                return 'Необхідно ввести числове значення';
              } else if (int.parse(ssd) < 0) {
                return 'Число повинно бути не менше 0';
              } else if (int.parse(ssd) > 4096) {
                return 'Число повинно бути не більше 4096';
              }
              return null;
            },
            onChanged: (ssd) {
              try {
                widget.model.ssd = int.tryParse(ssd.trim());
              } catch (ex) {
                print(ex);
              }
            },
          ),
          TextFormField(
            initialValue: widget.model.screen.toString(),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть діагональ екрану моделі',
              icon: Icon(
                Icons.fit_screen,
              ),
            ),
            validator: (screen) {
              if (screen == null || screen.trim().isEmpty) {
                return 'Поле не повинно бути порожнім';
              } else if (double.tryParse(screen) == null) {
                return 'Необхідно ввести числове значення';
              } else if (double.parse(screen) < 9) {
                return 'Число повинно бути не менше 9';
              } else if (double.parse(screen) > 17) {
                return 'Число повинно бути не більше 17';
              }
              return null;
            },
            onChanged: (screen) {
              try {
                widget.model.screen = double.tryParse(screen.trim());
              } catch (ex) {
                print(ex);
              }
            },
          ),
          TextFormField(
            initialValue: widget.model.os,
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть назву операційної системи',
              icon: Icon(Icons.android),
            ),
            validator: (os) {
              return os == null || os.trim().isEmpty
                  ? 'Поле не повинно бути порожнім'
                  : null;
            },
            onChanged: (os) {
              widget.model.os = os.trim();
            },
          ),
          TextFormField(
            initialValue: widget.model.weight.toString(),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть вагу моделі в кілограмах',
              icon: Icon(
                Icons.arrow_downward,
              ),
            ),
            validator: (weight) {
              if (weight == null || weight.trim().isEmpty) {
                return 'Поле не повинно бути порожнім';
              } else if (double.tryParse(weight) == null) {
                return 'Необхідно ввести числове значення';
              } else if (double.parse(weight) < 0) {
                return 'Число повинно бути не менше 0';
              } else if (double.parse(weight) > 7) {
                return 'Число повинно бути не більше 7';
              }
              return null;
            },
            onChanged: (weight) {
              try {
                widget.model.weight = double.tryParse(weight.trim());
              } catch (ex) {
                print(ex);
              }
            },
          ),
          TextFormField(
            initialValue: widget.model.price.toString(),
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              hintText: 'Введіть ціну моделі',
              icon: Icon(
                Icons.money,
              ),
            ),
            validator: (price) {
              if (price == null || price.trim().isEmpty) {
                return 'Поле не повинно бути порожнім';
              } else if (double.tryParse(price) == null) {
                return 'Необхідно ввести числове значення';
              } else if (double.parse(price) < 0) {
                return 'Число повинно бути не менше 0';
              } else if (double.parse(price) > 500000) {
                return 'Число повинно бути не більше 500000';
              }
              return null;
            },
            onChanged: (price) {
              try {
                widget.model.price = double.tryParse(price.trim());
              } catch (ex) {
                print(ex);
              }
            },
          ),
          TextButton(
            onPressed: () async {
              var selectedFile = await PopupDialogs.showImagePickerDialog(
                  context, 'Зображення моделі ноутбука');
              if (selectedFile != null) {
                laptopImage = selectedFile;
              }
              if (laptopImage != null) {
                setState(() {
                  laptopModelImageURL = pathUtil.basename(laptopImage.path);
                });
              }
            },
            child: Text(
              'Завантажити зображення ноутбука',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          laptopModelImageURL != null && laptopModelImageURL.isNotEmpty
              ? Text(
                  'Завантажено файл: $laptopModelImageURL',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.deepPurple,
                  ),
                )
              : Container(),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () async {
              if (widget.formKey.currentState.validate()) {
                if (laptopImage != null) {
                  var downloadURL =
                      await Utility.uploadFile(laptopImage, 'laptops');
                  widget.model.modelImagePath = downloadURL;
                }
                if (widget.arguments.isForUpdate) {
                  bool result = await laptopBloc.updateLaptop(
                      widget.arguments.id, widget.model);
                  if (result) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Помилка при відправці даних!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  bool result = await laptopBloc.addLaptop(widget.model);
                  if (result) {
                    Navigator.pushNamed(context, '/home');
                  } else {
                    final snackBar = SnackBar(
                      content: Text('Помилка при відправці даних!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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
    );
  }
}
