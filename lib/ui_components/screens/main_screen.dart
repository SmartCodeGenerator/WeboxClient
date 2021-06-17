import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/config/screen_args/laptop_form_arguments.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/ui_components/utils/catalog_page.dart';
import 'package:webox/ui_components/utils/comparisons_page.dart';
import 'package:webox/ui_components/utils/laptop_page_params.dart';
import 'package:webox/ui_components/utils/main_screen_drawer.dart';
import 'package:webox/ui_components/utils/preferences_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AccountModel _accountModel;
  int _selectedIndex = 0;
  final _itemViews = <Widget>[
    Center(
      child: CircularProgressIndicator(),
    ),
    Center(
      child: Text('Порівняння в розробці'),
    ),
    Center(
      child: Text('Вподобання в розробці'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    accountBloc.fetchUserAccount();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: accountBloc.userAccount,
      builder: (context, AsyncSnapshot<AccountModel> snapshot) {
        if (snapshot.hasData) {
          _accountModel = snapshot.data;
          var catalogPage = CatalogPage(_accountModel.isEmployee);
          _itemViews[0] = catalogPage;
          _itemViews[1] = ComparisonsPage(
              _accountModel.isEmployee,
              laptopPageParams.pageIndex,
              laptopPageParams.sortOrder,
              laptopPageParams.laptopQueryParams);
          _itemViews[2] = PreferencesPage(
              _accountModel.isEmployee,
              laptopPageParams.pageIndex,
              laptopPageParams.sortOrder,
              laptopPageParams.laptopQueryParams);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Webox',
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.pushNamed(context, '/laptop-search', arguments: {
                      'sortOrder': laptopPageParams.sortOrder,
                      'params': laptopPageParams.laptopQueryParams,
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/shopping-cart',
                      arguments: {
                        'pageIndex': laptopPageParams.pageIndex,
                        'sortOrder': laptopPageParams.sortOrder,
                        'params': laptopPageParams.laptopQueryParams,
                      },
                    );
                  },
                ),
              ],
            ),
            drawer: MainScreenDrawer(
              _accountModel,
              laptopPageParams.pageIndex,
              laptopPageParams.sortOrder,
              laptopPageParams.laptopQueryParams,
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: _itemViews[_selectedIndex],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.laptop,
                  ),
                  label: 'Каталог',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.compare_outlined,
                  ),
                  label: 'Порівняння',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite,
                  ),
                  label: 'Вподобання',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              unselectedFontSize: 14.0,
              selectedFontSize: 16.33,
            ),
            floatingActionButton:
                _accountModel.isEmployee && _selectedIndex == 0
                    ? FloatingActionButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/laptops/form',
                              arguments: LaptopFormArguments(null, false));
                        },
                        child: Icon(
                          Icons.add,
                          size: 30.0,
                        ),
                      )
                    : null,
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
