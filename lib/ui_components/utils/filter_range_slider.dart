import 'package:flutter/material.dart';
import 'package:webox/ui_components/utils/laptop_page_params.dart';

class FilterRangeSlider extends StatefulWidget {
  final double minValue, maxValue;
  final bool isPrice;
  const FilterRangeSlider(this.minValue, this.maxValue, this.isPrice, {Key key})
      : super(key: key);

  @override
  _FilterRangeSliderState createState() => _FilterRangeSliderState();
}

class _FilterRangeSliderState extends State<FilterRangeSlider> {
  double _minValue;
  double _maxValue;
  bool _isPrice;
  RangeValues _rangeValues;

  @override
  void initState() {
    super.initState();
    _minValue = widget.minValue;
    _maxValue = widget.maxValue;
    _isPrice = widget.isPrice;
    if (_isPrice) {
      _rangeValues = RangeValues(
          laptopPageParams.laptopQueryParams.minPrice != 0
              ? laptopPageParams.laptopQueryParams.minPrice
              : _minValue,
          laptopPageParams.laptopQueryParams.maxPrice != 0
              ? laptopPageParams.laptopQueryParams.maxPrice
              : _maxValue);
    } else {
      _rangeValues = RangeValues(
          laptopPageParams.laptopQueryParams.minWeight != 0
              ? laptopPageParams.laptopQueryParams.minWeight
              : _minValue,
          laptopPageParams.laptopQueryParams.maxWeight != 0
              ? laptopPageParams.laptopQueryParams.maxWeight
              : _maxValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RangeSlider(
          values: _rangeValues,
          min: _minValue,
          max: _maxValue,
          onChanged: (values) {
            setState(() {
              _rangeValues = values;
            });
            if (_isPrice) {
              laptopPageParams.laptopQueryParams.minPrice =
                  _rangeValues.start.round() + .0;
              laptopPageParams.laptopQueryParams.maxPrice =
                  _rangeValues.end.round() + .0;
            } else {
              laptopPageParams.laptopQueryParams.minWeight = _rangeValues.start;
              laptopPageParams.laptopQueryParams.maxWeight = _rangeValues.end;
            }
          },
        ),
        _isPrice
            ? Text(
                '${_rangeValues.start.round() + .0} \u{20b4} ' +
                    '- ${_rangeValues.end.round() + .0} \u{20b4}',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              )
            : Text(
                '${_rangeValues.start.toStringAsFixed(2)} кг ' +
                    '- ${_rangeValues.end.toStringAsFixed(2)} кг',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
      ],
    );
  }
}
