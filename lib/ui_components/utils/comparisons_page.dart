import 'package:flutter/material.dart';
import 'package:webox/blocs/comparison_bloc.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/models/comparison_model.dart';
import 'package:webox/ui_components/utils/compare_page.dart';

class ComparisonsPage extends StatelessWidget {
  final pageController = PageController(initialPage: 0);
  final bool isEmployee;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;
  ComparisonsPage(
      this.isEmployee, this.pageIndex, this.sortOrder, this.laptopQueryParams,
      {Key key})
      : super(key: key);

  List<ComparePage> buidComparePages(List<ComparisonModel> comparisons) {
    List<ComparePage> pages = [];
    for (int i = 0; i < comparisons.length; i++) {
      for (int j = 0; j < comparisons.length; j++) {
        if (i < j) {
          pages.add(ComparePage(
            [comparisons[i], comparisons[j]],
            isEmployee,
            pageIndex,
            sortOrder,
            laptopQueryParams,
            key: Key('$i$j'),
          ));
        }
      }
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    comparisonBloc.fetchComparisons();
    return StreamBuilder(
      stream: comparisonBloc.comparisons,
      builder: (context, AsyncSnapshot<List<ComparisonModel>> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Center(
            child: Text(
              'Помилка при завантаженні порівнянь',
              style: TextStyle(
                fontSize: 16.33,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          var comparisons = snapshot.data;
          return comparisons.length < 2
              ? Center(
                  child: Text(
                    'Для відображення порівнянь необхідно додати принаймні ' +
                        '2 моделі. На даний момент додано моделей: ' +
                        '${comparisons.length}',
                    style: TextStyle(
                      fontSize: 16.33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        children: buidComparePages(comparisons),
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/criteria-selection',
                            arguments: {
                              'comparisons': comparisons,
                              'pageIndex': pageIndex,
                              'sortOrder': sortOrder,
                              'params': laptopQueryParams,
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
                            fontSize: 16.33,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
