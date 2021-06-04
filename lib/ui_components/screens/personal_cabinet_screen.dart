import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';
import 'package:webox/models/account_model.dart';
import 'package:webox/models/edit_user_info_model.dart';
import 'package:webox/ui_components/utils/popup_dialogs.dart';
import 'package:webox/ui_components/utils/utility.dart';

class PersonalCabinetScreen extends StatelessWidget {
  PersonalCabinetScreen({Key key}) : super(key: key) {
    accountBloc.fetchUserAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webox'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: StreamBuilder(
            stream: accountBloc.userAccount,
            builder: (context, AsyncSnapshot<AccountModel> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error.toString());
              } else if (snapshot.hasData) {
                var model = snapshot.data;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 85.0,
                            backgroundImage: NetworkImage(
                              model.profileImagePath,
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              var selectedFile =
                                  await PopupDialogs.showImagePickerDialog(
                                      context,
                                      'Зображення профілю користувача');
                              if (selectedFile != null) {
                                var downloadURL = await Utility.uploadFile(
                                    selectedFile, 'profiles');
                                var statusCode = await accountBloc
                                    .updateProfileImage(downloadURL);
                                if (statusCode == 200) {
                                  accountBloc.fetchUserAccount();
                                } else if (statusCode == 401) {
                                  Navigator.pushNamed(context, '/login');
                                } else {
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Помилка при оновленні зображення профілю!'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 24.0,
                              ),
                              child: Icon(
                                Icons.image,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                      Column(
                        children: [
                          Text(
                            model.fullName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/edit-account-information',
                                      arguments: EditUserInfoModel(
                                          model.firstName, model.lastName));
                                },
                                child: Text(
                                  'Редагувати',
                                  style: TextStyle(
                                    fontSize: 16.33,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                      Column(
                        children: [
                          Text(
                            model.email,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  var result = await accountBloc
                                      .getEmailUpdateVerificationCode();
                                  if (result.contains('Помилка')) {
                                    var snackBar =
                                        SnackBar(content: Text(result));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  } else if (result == '401') {
                                    Navigator.pushNamed(context, '/login');
                                  } else {
                                    Navigator.pushNamed(
                                      context,
                                      '/verification',
                                      arguments: {
                                        'title': 'Оновлення електронної пошти облікового запису',
                                        'email': model.email,
                                        'code': result,
                                        'nextRoute': '/update-email',
                                      },
                                    );
                                  }
                                },
                                child: Text(
                                  'Редагувати',
                                  style: TextStyle(
                                    fontSize: 16.33,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2.0,
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 24.0,
                              ),
                              child: Text(
                                'Змінити пароль',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                                horizontal: 24.0,
                              ),
                              child: Text(
                                'Скинути пароль',
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
