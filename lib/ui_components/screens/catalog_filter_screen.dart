import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/ui_components/utils/filter_range_slider.dart';
import 'package:webox/ui_components/utils/laptop_page_params.dart';

class CatalogFilterScreen extends StatefulWidget {
  const CatalogFilterScreen({Key key}) : super(key: key);

  @override
  _CatalogFilterScreenState createState() => _CatalogFilterScreenState();
}

class _CatalogFilterScreenState extends State<CatalogFilterScreen> {
  List<String> _manufacturers = [];
  List<String> _processors = [];
  List<String> _graphics = [];
  List<int> _ram = [];
  List<int> _ssd = [];
  List<double> _screens = [];
  List<String> _os = [];
  double _minWeight = 0.0;
  double _maxWeight = 0.0;
  double _minPrice = 0.0;
  double _maxPrice = 0.0;
  List<bool> _manufacturersChecked = [];
  List<bool> _processorsChecked = [];
  List<bool> _graphicsChecked = [];
  List<bool> _ramChecked = [];
  List<bool> _ssdChecked = [];
  List<bool> _screensChecked = [];
  List<bool> _osChecked = [];

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    _manufacturers = args['manufacturers'] as List<String>;
    _processors = args['processors'] as List<String>;
    _graphics = args['graphics'] as List<String>;
    _ram = args['ram'] as List<int>;
    _ssd = args['ssd'] as List<int>;
    _screens = args['screens'] as List<double>;
    _os = args['os'] as List<String>;
    _minWeight = args['minWeight'] as double;
    _maxWeight = args['maxWeight'] as double;
    _minPrice = args['minPrice'] as double;
    _maxPrice = args['maxPrice'] as double;
    for (var manufacturer in _manufacturers) {
      _manufacturersChecked.add(laptopPageParams.laptopQueryParams.manufacturer
          .contains(manufacturer));
    }
    for (var processor in _processors) {
      _processorsChecked.add(
          laptopPageParams.laptopQueryParams.processor.contains(processor));
    }
    for (var graphics in _graphics) {
      _graphicsChecked
          .add(laptopPageParams.laptopQueryParams.graphics.contains(graphics));
    }
    for (var ram in _ram) {
      _ramChecked.add(laptopPageParams.laptopQueryParams.ram.contains(ram));
    }
    for (var ssd in _ssd) {
      _ssdChecked.add(laptopPageParams.laptopQueryParams.ssd.contains(ssd));
    }
    for (var screen in _screens) {
      _screensChecked
          .add(laptopPageParams.laptopQueryParams.screen.contains(screen));
    }
    for (var os in _os) {
      _osChecked.add(laptopPageParams.laptopQueryParams.os.contains(os));
    }
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text(
                      'Виробник',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _manufacturers
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _manufacturersChecked[
                                  _manufacturers.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _manufacturersChecked[
                                      _manufacturers.indexOf(e)] = checked;
                                });
                                if (checked) {
                                  laptopPageParams
                                      .laptopQueryParams.manufacturer
                                      .add(e);
                                } else {
                                  laptopPageParams
                                      .laptopQueryParams.manufacturer
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Процесор',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _processors
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _processorsChecked[_processors.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _processorsChecked[_processors.indexOf(e)] =
                                      checked;
                                });
                                if (checked) {
                                  laptopPageParams.laptopQueryParams.processor
                                      .add(e);
                                } else {
                                  laptopPageParams.laptopQueryParams.processor
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Відеокарта',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _graphics
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _graphicsChecked[_graphics.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _graphicsChecked[_graphics.indexOf(e)] =
                                      checked;
                                });
                                if (checked) {
                                  laptopPageParams.laptopQueryParams.graphics
                                      .add(e);
                                } else {
                                  laptopPageParams.laptopQueryParams.graphics
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Обсяг оперативної пам\'яті',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _ram
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _ramChecked[_ram.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _ramChecked[_ram.indexOf(e)] = checked;
                                });
                                if (checked) {
                                  laptopPageParams.laptopQueryParams.ram.add(e);
                                } else {
                                  laptopPageParams.laptopQueryParams.ram
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e.toString() + ' ГБ',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Обсяг накопичувача',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _ssd
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _ssdChecked[_ssd.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _ssdChecked[_ssd.indexOf(e)] = checked;
                                });
                                if (checked) {
                                  laptopPageParams.laptopQueryParams.ssd.add(e);
                                } else {
                                  laptopPageParams.laptopQueryParams.ssd
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e.toString() + ' ГБ SSD',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Діагональ екрана',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _screens
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _screensChecked[_screens.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _screensChecked[_screens.indexOf(e)] =
                                      checked;
                                });
                                if (checked) {
                                  laptopPageParams.laptopQueryParams.screen
                                      .add(e);
                                } else {
                                  laptopPageParams.laptopQueryParams.screen
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e.toString() + '``',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  ExpansionTile(
                    title: Text(
                      'Операційна система',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: _os
                        .map<Widget>(
                          (e) => ListTile(
                            leading: Checkbox(
                              value: _osChecked[_os.indexOf(e)],
                              onChanged: (checked) {
                                setState(() {
                                  _osChecked[_os.indexOf(e)] = checked;
                                });
                                if (checked) {
                                  laptopPageParams.laptopQueryParams.os.add(e);
                                } else {
                                  laptopPageParams.laptopQueryParams.os
                                      .remove(e);
                                }
                              },
                            ),
                            title: Text(
                              e,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Вага:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FilterRangeSlider(_minWeight, _maxWeight, false),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Ціна:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  FilterRangeSlider(_minPrice, _maxPrice, true),
                  SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      laptopBloc.fetchLaptopPageModel(
                          laptopPageParams.pageIndex,
                          laptopPageParams.sortOrder,
                          laptopPageParams.laptopQueryParams);
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'Застосувати',
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
      ),
    );
  }
}
