import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webox/config/query_params/laptop_params.dart';
import 'package:webox/config/screen_args/personal_review_arguments.dart';
import 'package:webox/models/account_model.dart';

class MainScreenDrawer extends StatefulWidget {
  final accountModel;
  final int pageIndex;
  final String sortOrder;
  final LaptopQueryParams laptopQueryParams;

  MainScreenDrawer(
    this.accountModel,
    this.pageIndex,
    this.sortOrder,
    this.laptopQueryParams,
  );

  @override
  _MainScreenDrawerState createState() => _MainScreenDrawerState();
}

class _MainScreenDrawerState extends State<MainScreenDrawer> {
  AccountModel _accountModel;

  @override
  void initState() {
    super.initState();
    _accountModel = widget.accountModel;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36.0,
                  backgroundImage: NetworkImage(_accountModel.profileImagePath),
                ),
                SizedBox(
                  width: 12.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _accountModel.fullName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      _accountModel.email,
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              size: 25.0,
            ),
            title: Text(
              'Особистий кабінет',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              // TODO: implement personal info editing screen
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag,
              size: 25.0,
            ),
            title: Text(
              'Мої замовлення',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              // TODO: implement orders screen
            },
          ),
          ListTile(
            leading: Icon(
              Icons.comment,
              size: 25.0,
            ),
            title: Text(
              'Мої відгуки',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/reviews/user',
                arguments: PersonalReviewArguments(
                  _accountModel.isEmployee,
                  widget.pageIndex,
                  widget.sortOrder,
                  widget.laptopQueryParams,
                ),
              );
            },
          ),
          _accountModel.isEmployee
              ? ListTile(
                  leading: Icon(
                    Icons.storage,
                    size: 25.0,
                  ),
                  title: Text(
                    'Зберігання товарів',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  onTap: () {
                    // TODO: implement storage lots screen
                  },
                )
              : Container(),
          _accountModel.isEmployee
              ? ListTile(
                  leading: Icon(
                    Icons.post_add,
                    size: 25.0,
                  ),
                  title: Text(
                    'Постачальники',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  onTap: () {
                    // TODO: implement deliverers screen
                  },
                )
              : Container(),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 25.0,
            ),
            title: Text(
              'Вихід',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              var result = await prefs.remove('apiAccessToken');
              if (result) {
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
        ],
      ),
    );
  }
}
