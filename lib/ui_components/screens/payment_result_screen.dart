import 'package:flutter/material.dart';

class PaymentResultScreen extends StatelessWidget {
  const PaymentResultScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var success = ModalRoute.of(context).settings.arguments as bool;
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                success ? Icons.check_circle_outline : Icons.error_outline,
                color: success ? Colors.blue : Colors.red,
                size: 120.0,
              ),
              Text(
                success ? 'Вітаємо!' : 'Помилка!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                success
                    ? 'Оплата Вашого замовлення пройшла успішно. ' +
                        'Ви можете переглянути його поточний статус на ' +
                        'вкладинці "Мої замовлення" на панелі користувача.'
                    : 'На жаль, під час оплати Вашого замовлення сталася ' +
                        'помилка. Рекомендуємо повернутися до каталого та ' +
                        'повторити спробу пізніше.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/home');
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    'Повернутися до каталогу',
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
    );
  }
}
