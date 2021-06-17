import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/config/screen_args/laptop_form_arguments.dart';
import 'package:webox/models/laptop_model.dart';
import 'package:webox/ui_components/utils/laptop_form.dart';

class LaptopFormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  Widget buildLaptopFormForUpdate(LaptopFormArguments arguments) {
    laptopBloc.fetchLaptopModel(arguments.id);
    return StreamBuilder(
      stream: laptopBloc.laptopModel,
      builder: (context, AsyncSnapshot<LaptopModel> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
        }
        if (snapshot.hasData) {
          return LaptopForm(
            formKey: formKey,
            model: snapshot.data,
            arguments: arguments,
          );
        }
        return Center(
          child: Text(
            'Помилка при завантаженні початкових даних!',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var arguments =
        ModalRoute.of(context).settings.arguments as LaptopFormArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Webox',
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: arguments.isForUpdate
                ? buildLaptopFormForUpdate(arguments)
                : LaptopForm(
                    formKey: formKey,
                    model: LaptopModel('', '', '', '', 0, 0, 0.0, '', 0.0, 0.0,
                        0.0, false, null),
                    arguments: arguments,
                  ),
          ),
        ),
      ),
    );
  }
}
