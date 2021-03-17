import 'package:flutter/material.dart';
import 'package:webox/config/routes.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/services/network_provider.dart';
import 'package:webox/ui_components/screens/login_screen.dart';
import 'package:webox/ui_components/screens/main_screen.dart';

class WeboxApp extends StatefulWidget {
  @override
  _WeboxAppState createState() => _WeboxAppState();
}

class _WeboxAppState extends State<WeboxApp> {
  Future<AccountModel> result;

  @override
  void initState() {
    super.initState();
    result = NetworkProvider.accountService.getAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      routes: routes,
      home: FutureBuilder(
        future: result,
        builder: (context, AsyncSnapshot<AccountModel> snapshot) {
          if (snapshot.hasData) {
            return MainScreen();
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return LoginScreen();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
