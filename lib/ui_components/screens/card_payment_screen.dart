import 'package:flutter/material.dart';
import 'package:webox/blocs/laptop_bloc.dart';
import 'package:webox/blocs/order_bloc.dart';
import 'package:webox/blocs/storage_lot_bloc.dart';
import 'package:webox/models/order_model.dart';
import 'package:webox/repositories/order_item_repository.dart';
import 'package:webox/ui_components/utils/popup_dialogs.dart';

class CardPaymentScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  CardPaymentScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var model = args['model'] as OrderModel;
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
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'інформація для оплати'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Divider(
                    thickness: 2.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Номер картки',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 16,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Введіть номер картки',
                          ),
                          validator: (cardNumber) {
                            if (cardNumber == null ||
                                cardNumber.trim().isEmpty) {
                              return 'Поле не повинно бути порожнім';
                            } else if (int.tryParse(cardNumber) == null) {
                              return 'Необхідно ввести числове значення';
                            } else if (cardNumber.trim().length < 16) {
                              return 'Довжина номеру повинна складати 16 цифр';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Власник картки',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        flex: 8,
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Введіть ім\'я та прізвище',
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Cпливає',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'ММ',
                          ),
                          validator: (expiryMonth) {
                            if (expiryMonth == null ||
                                expiryMonth.trim().isEmpty) {
                              return 'Поле не повинно бути порожнім';
                            } else if (int.tryParse(expiryMonth) == null) {
                              return 'Необхідно ввести числове значення';
                            } else if (expiryMonth.trim().length < 2) {
                              return 'Довжина номеру повинна складати 2 цифри';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          '/',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            hintText: 'РР',
                          ),
                          validator: (expiryYear) {
                            if (expiryYear == null ||
                                expiryYear.trim().isEmpty) {
                              return 'Поле не повинно бути порожнім';
                            } else if (int.tryParse(expiryYear) == null) {
                              return 'Необхідно ввести числове значення';
                            } else if (expiryYear.trim().length < 2) {
                              return 'Довжина номеру повинна складати 2 цифри';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'CVC',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 24.0,
                      ),
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          decoration: InputDecoration(
                            hintText: '000',
                          ),
                          validator: (cvc) {
                            if (cvc == null || cvc.trim().isEmpty) {
                              return 'Поле не повинно бути порожнім';
                            } else if (int.tryParse(cvc) == null) {
                              return 'Необхідно ввести числове значення';
                            } else if (cvc.trim().length < 3) {
                              return 'Довжина номеру повинна складати 3 цифри';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Container(),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Сума до сплати:',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        model.price.toString() + ' \u{20b4}',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        var result = await PopupDialogs.showConfirmDialog(
                            context,
                            'Підтвердження оплати',
                            'Ви погоджуєтеся на зняття з Вашого рахунку вказаної суми: ${model.price} \u{20b4} ?');
                        if (result) {
                          var statusCode = await orderBloc.makeOrder(model);
                          if (statusCode == 200) {
                            orderBloc.fetchOrders();
                            storageLotBloc.fetchStorageLots();
                            laptopBloc.refreshCatalog(args['pageIndex'],
                                args['sortOrder'], args['params']);
                            await OrderItemRepository.truncate();
                            Navigator.pushNamed(
                              context,
                              '/payment-result',
                              arguments: true,
                            );
                          } else if (statusCode == 401) {
                            Navigator.pushNamed(context, '/login');
                          } else {
                            Navigator.pushNamed(
                              context,
                              '/payment-result',
                              arguments: false,
                            );
                          }
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'Сплатити',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
