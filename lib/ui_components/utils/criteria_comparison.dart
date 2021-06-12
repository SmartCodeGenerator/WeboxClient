import 'package:flutter/material.dart';

class CriteriaComparison extends StatefulWidget {
  final String criterionA;
  final String criterionB;
  final List<List<double>> criteriaMatrix;
  final int i;
  final int j;
  const CriteriaComparison(
      this.criterionA, this.criterionB, this.criteriaMatrix, this.i, this.j,
      {Key key})
      : super(key: key);

  @override
  _CriteriaComparisonState createState() => _CriteriaComparisonState();
}

class _CriteriaComparisonState extends State<CriteriaComparison> {
  double _sliderValue = 8;

  double convertSliderValueToComparisonValue(int sliderValue) {
    switch (sliderValue) {
      case 0:
        return 9.0;
        break;
      case 1:
        return 8.0;
        break;
      case 2:
        return 7.0;
        break;
      case 3:
        return 6.0;
        break;
      case 4:
        return 5.0;
        break;
      case 5:
        return 4.0;
        break;
      case 6:
        return 3.0;
        break;
      case 7:
        return 2.0;
        break;
      case 8:
        return 1.0;
        break;
      case 9:
        return 1 / 2.0;
        break;
      case 10:
        return 1 / 3.0;
        break;
      case 11:
        return 1 / 4.0;
        break;
      case 12:
        return 1 / 5.0;
        break;
      case 13:
        return 1 / 6.0;
        break;
      case 14:
        return 1 / 7.0;
        break;
      case 15:
        return 1 / 8.0;
        break;
      case 16:
        return 1 / 9.0;
        break;
      default:
        return 1.0;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 20.0,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              widget.criterionA,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Slider(
              value: _sliderValue,
              min: 0,
              max: 16,
              divisions: 16,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
                var comparisonValue =
                    convertSliderValueToComparisonValue(_sliderValue.round());
                widget.criteriaMatrix[widget.i][widget.j] = comparisonValue;
                widget.criteriaMatrix[widget.j][widget.i] = 1 / comparisonValue;
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              widget.criterionB,
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
