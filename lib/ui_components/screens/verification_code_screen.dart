import 'package:flutter/material.dart';
import 'package:webox/blocs/account_bloc.dart';

class VerificationCodeScreen extends StatefulWidget {
  VerificationCodeScreen({Key key}) : super(key: key);

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic> args;
  bool isProperLength = false;
  String inputCode;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  args['title'],
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'На електронну адресу ',
                        ),
                        TextSpan(
                          text: args['email'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: ' було надіслано код верифікації. ' +
                              'Перегляньте отриманий лист та введіть вказане в ньому значення у відповідне поле.',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    controller: controller,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Введіть код верифікації',
                      icon: Icon(
                        Icons.code,
                      ),
                    ),
                    validator: (code) {
                      if (code == null || code.trim().isEmpty) {
                        return 'Поле не повинно бути порожнім';
                      } else if (int.tryParse(code) == null) {
                        return 'Необхідно ввести числове значення';
                      }
                      return null;
                    },
                    onChanged: (code) {
                      if (code.trim().length == 6) {
                        setState(() {
                          isProperLength = true;
                        });
                      } else {
                        setState(() {
                          isProperLength = false;
                        });
                      }
                      inputCode = code.trim();
                    },
                  ),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState.validate()) {
                          if (isProperLength) {
                            if (inputCode == args['code']) {
                              Navigator.pushNamed(context, args['nextRoute'],
                                  arguments:
                                      args['nextRoute'] == '/update-email'
                                          ? {
                                              'title': args['title'],
                                              'email': args['email']
                                            }
                                          : null);
                            } else {
                              var snackBar = SnackBar(
                                content: Text('Введений код є неправильним'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        }
                      },
                      child: Text(
                        'ПІДТВЕРДИТИ',
                        style: TextStyle(
                          color: isProperLength ? Colors.white : Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: isProperLength ? Colors.blue : Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextButton(
                      onPressed: () async {
                        var result = args['nextRoute'] == '/update-email'
                            ? await accountBloc.getEmailUpdateVerificationCode()
                            : '111111';
                        if (result.contains('Помилка')) {
                          var snackBar = SnackBar(content: Text(result));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else if (result == '401') {
                          Navigator.pushNamed(context, '/login');
                        } else {
                          args['code'] = result;
                        }
                      },
                      child: Text(
                        'Повторно надіслати код',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
