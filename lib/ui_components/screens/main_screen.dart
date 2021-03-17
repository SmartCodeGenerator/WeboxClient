import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/ui_components/utils/main_screen_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  AccountModel _accountModel;
  int _selectedIndex = 0;
  final _itemViews = [
    Center(
      child: Text('Каталог в розробці'),
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
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Webox',
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    // TODO: implement shopping cart
                  },
                ),
              ],
            ),
            drawer: MainScreenDrawer(_accountModel),
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
                          // TODO: implement AddLaptopForm
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
