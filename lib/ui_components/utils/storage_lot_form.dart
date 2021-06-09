import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/storage_lot_model.dart';

class StorageLotForm extends StatefulWidget {
  final StorageLotModel model;
  final Map<String, String> options;
  final bool update;
  final String id;

  const StorageLotForm(this.model, this.options, this.update, this.id,
      {Key key})
      : super(key: key);

  @override
  _StorageLotFormState createState() => _StorageLotFormState();
}

class _StorageLotFormState extends State<StorageLotForm> {
  final _formKey = GlobalKey<FormState>();
  StorageLotModel _model;
  Map<String, String> _options;
  bool _update;
  String _id;
  List<String> _dropdownValues;
  String _dropdownValue;

  @override
  void initState() {
    super.initState();
    _model = widget.model;
    _options = widget.options;
    _update = widget.update;
    _id = widget.id;
    _dropdownValues = _options.keys.toList();
    if (_update) {
      for (var entry in _options.entries) {
        if (entry.value == _model.delivererId) {
          _dropdownValue = entry.key;
        }
      }
    } else {
      _dropdownValue = _dropdownValues.first;
      _model.delivererId = _options[_dropdownValue];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                  initialValue: _model.warehouseAddress,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Введіть адресу складу',
                    icon: Icon(
                      Icons.location_pin,
                    ),
                  ),
                  validator: (warehouseAddress) {
                    return warehouseAddress == null ||
                            warehouseAddress.trim().isEmpty
                        ? 'Поле не повинно бути порожнім'
                        : null;
                  },
                  onChanged: (warehouseAddress) {
                    _model.warehouseAddress = warehouseAddress.trim();
                  },
                ),
                TextFormField(
                  initialValue: _model.laptopsCostPerUnit.toString(),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Введіть вартість одиниці товару',
                    icon: Icon(Icons.money),
                  ),
                  validator: (laptopsCostPerUnit) {
                    if (laptopsCostPerUnit == null ||
                        laptopsCostPerUnit.trim().isEmpty) {
                      return 'Поле не повинно бути порожнім';
                    } else if (double.tryParse(laptopsCostPerUnit) == null) {
                      return 'Необхідно ввести числове значення';
                    } else if (double.parse(laptopsCostPerUnit) < 1) {
                      return 'Число повинно бути не менше 1';
                    } else if (double.parse(laptopsCostPerUnit) > 500000) {
                      return 'Число повинно бути не більше 500000';
                    }
                    return null;
                  },
                  onChanged: (laptopsCostPerUnit) {
                    try {
                      _model.laptopsCostPerUnit =
                          double.tryParse(laptopsCostPerUnit.trim());
                    } catch (ex) {
                      print(ex);
                    }
                  },
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Постачальник:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    DropdownButton(
                      value: _dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 30.0,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _dropdownValue = value;
                          _model.delivererId = _options[value];
                        });
                      },
                      items: _dropdownValues
                          .map<DropdownMenuItem<String>>(
                            (option) => DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                {
                  var statusCode = !_update
                      ? await storageLotBloc.saveStorageLot(_model)
                      : await storageLotBloc.updateStorageLot(_id, _model);
                  if (statusCode == 200) {
                    storageLotBloc.fetchStorageLots();
                    laptopBloc.fetchLaptopModel(_model.laptopId);
                    if (_update) {
                      storageLotBloc.fetchStorageLot(_id);
                    }
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
    );
  }
}
