import 'package:flutter/material.dart';
import 'package:webox/models/comparison_model.dart';
import 'package:webox/ui_components/utils/criteria_comparison.dart';
import 'package:webox/ui_components/utils/recommendation_calculator.dart';

class CriteriaComparisonScreen extends StatelessWidget {
  const CriteriaComparisonScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var criteria = args['criteria'] as List<String>;
    var alternatives = args['alternatives'] as List<ComparisonModel>;
    List<List<double>> criteriaMatrix = [];
    List<CriteriaComparison> criteriaComparisons = [];
    for (int i = 0; i < criteria.length; i++) {
      List<double> criteriaMatrixRow = [];
      for (int j = 0; j < criteria.length; j++) {
        criteriaMatrixRow.add(1.0);
        if (i < j) {
          criteriaComparisons.add(CriteriaComparison(
              criteria[i], criteria[j], criteriaMatrix, i, j));
        }
      }
      criteriaMatrix.add(criteriaMatrixRow);
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
          child: Column(
            children: [
              SizedBox(
                height: 16.0,
              ),
              Text(
                'Порівняння критеріїв',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Expanded(
                child: ListView(
                  children: criteriaComparisons,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () {
                  var calculator = RecommendationCalculator(
                      criteria, alternatives, criteriaMatrix);
                  var recommendedLaptopModel =
                      calculator.findRecommendedModel();
                  Navigator.pushNamed(context, '/comparison-winner', arguments: {
                    'model': recommendedLaptopModel.laptopModel,
                    'pageIndex': args['pageIndex'],
                    'sortOrder': args['sortOrder'],
                    'params': args['params'],
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Отримати рекомендацію',
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
