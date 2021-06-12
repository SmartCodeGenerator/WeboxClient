import 'package:webox/models/comparison_model.dart';
import 'dart:math' as math;

import 'package:webox/models/laptop_model.dart';

class RecommendationCalculator {
  final List<String> criteria;
  final List<ComparisonModel> alternatives;
  final List<List<double>> criteriaMatrix;
  final random = math.Random();

  RecommendationCalculator(
      this.criteria, this.alternatives, this.criteriaMatrix);

  double rowGeometricMean(int rowIndex, List<List<double>> matrix) {
    double prod = 1.0;
    for (int j = 0; j < matrix.length; j++) {
      prod *= matrix[rowIndex][j];
    }
    return math.pow(prod, 1 / (matrix.length + .0)) as double;
  }

  double geometricMeanSum(List<List<double>> matrix) {
    double sum = 0.0;
    for (int i = 0; i < matrix.length; i++) {
      sum += rowGeometricMean(i, matrix);
    }
    return sum;
  }

  double maxEigenvalue() {
    double sum1 = 0.0;
    var meanSum = geometricMeanSum(criteriaMatrix);
    for (int j = 0; j < criteriaMatrix.length; j++) {
      var rowEigenvalue = rowGeometricMean(j, criteriaMatrix) / meanSum;
      double sum2 = 0.0;
      for (int i = 0; i < criteriaMatrix.length; i++) {
        sum2 += criteriaMatrix[i][j];
      }
      sum1 += rowEigenvalue * sum2;
    }
    return sum1;
  }

  double consistencyIndex() {
    int length = criteriaMatrix.length;
    return (maxEigenvalue() - length) / (length - 1);
  }

  double randomConsistency() {
    switch (criteriaMatrix.length) {
      case 3:
        return 0.58;
        break;
      case 4:
        return 0.9;
        break;
      case 5:
        return 1.12;
        break;
      case 6:
        return 1.24;
        break;
      default:
        return 0.0;
        break;
    }
  }

  double shiftMatrixValue(double value) {
    var shiftedValue = value;
    if (value <= 1.0) {
      shiftedValue = 2.0;
    } else if (value == 9.0) {
      shiftedValue = 8.0;
    } else {
      var result = random.nextBool();
      if (result) {
        shiftedValue++;
      } else {
        shiftedValue--;
      }
    }
    return shiftedValue;
  }

  void checkConsistencyRelation() {
    var consistencyRelation = consistencyIndex() / randomConsistency();
    if (consistencyRelation > 0.2) {
      for (int i = 0; i < criteriaMatrix.length; i++) {
        for (int j = 0; j < criteriaMatrix.length; j++) {
          if (i < j) {
            var shiftedValue = shiftMatrixValue(criteriaMatrix[i][j]);
            criteriaMatrix[i][j] = shiftedValue;
            criteriaMatrix[j][i] = 1.0 / shiftedValue;
          }
        }
      }
      checkConsistencyRelation();
    } else {
      return;
    }
  }

  double laptopComparisonValue(
      String criterion, LaptopWithIdModel model1, LaptopWithIdModel model2) {
    double comparisonValue = 1.0;
    if (criterion == 'Обсяг оперативної пам\'яті') {
      if (model1.ram >= model2.ram) {
        comparisonValue = model1.ram / (model2.ram + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        return comparisonValue.round() + .0;
      } else {
        comparisonValue = model2.ram / (model1.ram + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        var reversedComparisonValue = comparisonValue.round() + .0;
        return 1 / reversedComparisonValue;
      }
    } else if (criterion == 'Обсяг накопичувача') {
      if (model1.ssd >= model2.ssd) {
        comparisonValue = model1.ssd / (model2.ssd + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        return comparisonValue.round() + .0;
      } else {
        comparisonValue = model2.ssd / (model1.ssd + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        var reversedComparisonValue = comparisonValue.round() + .0;
        return 1 / reversedComparisonValue;
      }
    } else if (criterion == 'Діагональ екрана') {
      if (model1.screen >= model2.screen) {
        comparisonValue = model1.screen / (model2.screen + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        return comparisonValue.round() + .0;
      } else {
        comparisonValue = model2.screen / (model1.screen + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        var reversedComparisonValue = comparisonValue.round() + .0;
        return 1 / reversedComparisonValue;
      }
    } else if (criterion == 'Вага') {
      if (model1.weight <= model2.weight) {
        comparisonValue = model2.weight / (model1.weight + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        return comparisonValue.round() + .0;
      } else {
        comparisonValue = model1.weight / (model2.weight + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        var reversedComparisonValue = comparisonValue.round() + .0;
        return 1 / reversedComparisonValue;
      }
    } else if (criterion == 'Ціна') {
      if (model1.price <= model2.price) {
        comparisonValue = model2.price / (model1.price + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        return comparisonValue.round() + .0;
      } else {
        comparisonValue = model1.price / (model2.price + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        var reversedComparisonValue = comparisonValue.round() + .0;
        return 1 / reversedComparisonValue;
      }
    } else if (criterion == 'Рейтинг') {
      if (model1.rating >= model2.rating) {
        comparisonValue = model1.rating / (model2.rating + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        return comparisonValue.round() + .0;
      } else {
        comparisonValue = model2.rating / (model1.rating + .0);
        if (comparisonValue >= 9.0) {
          comparisonValue = 9.0;
        }
        var reversedComparisonValue = comparisonValue.round() + .0;
        return 1 / reversedComparisonValue;
      }
    }
    return comparisonValue;
  }

  ComparisonModel findRecommendedModel() {
    checkConsistencyRelation();

    List<List<List<double>>> alternativesMatrices = [];

    for (var criterion in criteria) {
      if (criterion != null && criterion.trim().isNotEmpty) {
        List<List<double>> alternativesMatrix = [];
        for (int i = 0; i < alternatives.length; i++) {
          List<double> rowValues = [];
          for (int j = 0; j < alternatives.length; j++) {
            rowValues.add(1.0);
          }
          alternativesMatrix.add(rowValues);
        }
        alternativesMatrices.add(alternativesMatrix);
      }
    }

    int counter = 0;
    for (var criterion in criteria) {
      if (criterion != null && criterion.trim().isNotEmpty) {
        var matrix = alternativesMatrices[counter++];
        for (int i = 0; i < alternatives.length; i++) {
          for (int j = 0; j < alternatives.length; j++) {
            if (i < j) {
              var comparisonValue = laptopComparisonValue(criterion,
                  alternatives[i].laptopModel, alternatives[j].laptopModel);
              matrix[i][j] = comparisonValue + .0;
              matrix[j][i] = 1 / (comparisonValue + .0);
            }
          }
        }
      }
    }

    List<List<double>> alternativesLocalPrioritiesMatrix = [];
    for (int i = 0; i < alternatives.length; i++) {
      List<double> rowValues = [];
      for (int j = 0; j < criteria.length; j++) {
        var matrix = alternativesMatrices[j];
        var meanSum = geometricMeanSum(matrix);
        rowValues.add(rowGeometricMean(i, matrix) / meanSum);
      }
      alternativesLocalPrioritiesMatrix.add(rowValues);
    }

    List<double> criteriaLocalPrioritiesVector = [];
    var criteriaMatrixMeanSum = geometricMeanSum(criteriaMatrix);
    for (int i = 0; i < criteriaMatrix.length; i++) {
      criteriaLocalPrioritiesVector
          .add(rowGeometricMean(i, criteriaMatrix) / criteriaMatrixMeanSum);
    }

    List<double> alternativesGlobalPrioritiesVector = [];
    for (int i = 0; i < alternativesLocalPrioritiesMatrix.length; i++) {
      double globalPriorityValue = 0;
      for (int j = 0; j < alternativesLocalPrioritiesMatrix[i].length; j++) {
        globalPriorityValue += alternativesLocalPrioritiesMatrix[i][j] *
            criteriaLocalPrioritiesVector[j];
      }
      alternativesGlobalPrioritiesVector.add(globalPriorityValue);
    }

    int maxIndex = 0;
    double maxValue = alternativesGlobalPrioritiesVector[0];
    for (int i = 0; i < alternativesGlobalPrioritiesVector.length; i++) {
      if (alternativesGlobalPrioritiesVector[i] > maxValue) {
        maxValue = alternativesGlobalPrioritiesVector[i];
        maxIndex = i;
      }
    }

    return alternatives[maxIndex];
  }
}
