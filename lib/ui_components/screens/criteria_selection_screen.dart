import 'package:flutter/material.dart';
import 'package:webox/models/comparison_model.dart';

class CriteriaSelectionScreen extends StatefulWidget {
  const CriteriaSelectionScreen({Key key}) : super(key: key);

  @override
  _CriteriaSelectionScreenState createState() =>
      _CriteriaSelectionScreenState();
}

class _CriteriaSelectionScreenState extends State<CriteriaSelectionScreen> {
  List<String> criteria = [];
  bool isRamSelected = false;
  bool isSsdSelected = false;
  bool isScreenSelected = false;
  bool isWeightSelected = false;
  bool isPriceSelected = false;
  bool isRatingSelected = false;

  @override
  Widget build(BuildContext context) {
    var comparisons =
        ModalRoute.of(context).settings.arguments as List<ComparisonModel>;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Відмітьте принаймні 3 характеристики, за якими ' +
                    'оцінюватимуться моделі з Вашого списку порівнянь.',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: isRamSelected,
                        onChanged: (isChecked) {
                          setState(() {
                            isRamSelected = isChecked;
                          });
                          if (isChecked) {
                            criteria.add('Обсяг оперативної пам\'яті');
                          } else {
                            criteria.remove('Обсяг оперативної пам\'яті');
                          }
                        },
                      ),
                      title: Text(
                        'Обсяг оперативної пам\'яті',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Checkbox(
                        value: isSsdSelected,
                        onChanged: (isChecked) {
                          setState(() {
                            isSsdSelected = isChecked;
                          });
                          if (isChecked) {
                            criteria.add('Обсяг накопичувача');
                          } else {
                            criteria.remove('Обсяг накопичувача');
                          }
                        },
                      ),
                      title: Text(
                        'Обсяг накопичувача',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Checkbox(
                        value: isScreenSelected,
                        onChanged: (isChecked) {
                          setState(() {
                            isScreenSelected = isChecked;
                          });
                          if (isChecked) {
                            criteria.add('Діагональ екрана');
                          } else {
                            criteria.remove('Діагональ екрана');
                          }
                        },
                      ),
                      title: Text(
                        'Діагональ екрана',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Checkbox(
                        value: isWeightSelected,
                        onChanged: (isChecked) {
                          setState(() {
                            isWeightSelected = isChecked;
                          });
                          if (isChecked) {
                            criteria.add('Вага');
                          } else {
                            criteria.remove('Вага');
                          }
                        },
                      ),
                      title: Text(
                        'Вага',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Checkbox(
                        value: isPriceSelected,
                        onChanged: (isChecked) {
                          setState(() {
                            isPriceSelected = isChecked;
                          });
                          if (isChecked) {
                            criteria.add('Ціна');
                          } else {
                            criteria.remove('Ціна');
                          }
                        },
                      ),
                      title: Text(
                        'Ціна',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Checkbox(
                        value: isRatingSelected,
                        onChanged: (isChecked) {
                          setState(() {
                            isRatingSelected = isChecked;
                          });
                          if (isChecked) {
                            criteria.add('Рейтинг');
                          } else {
                            criteria.remove('Рейтинг');
                          }
                        },
                      ),
                      title: Text(
                        'Рейтинг',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (criteria.length >= 3) {
                    Navigator.pushNamed(context, '/criteria-comparison',
                        arguments: {
                          'criteria': criteria,
                          'alternatives': comparisons,
                        });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Вибір критеріїв',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          content: Text(
                            'Ви обрали недостатню кількість критеріїв для ' +
                                'оцінки моделей. Необхідно відмітити ' +
                                'принаймні 3 характеристики.',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'ОК',
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
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Перейти до порівнянь критеріїв',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
