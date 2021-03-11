import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/account_model.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webox'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: StreamBuilder(
                stream: accountBloc.userAccount,
                builder: (context, AsyncSnapshot<AccountModel> snapshot) {
                  if (snapshot.hasData) {
                    var accountModel = snapshot.data;
                    return Column(
                      children: [
                        Image.network(accountModel.profileImagePath),
                        Text(accountModel.fullName),
                        Text(accountModel.email),
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: null,
        ),
      ),
    );
  }
}
