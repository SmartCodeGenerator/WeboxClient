import 'package:flutter/material.dart';
import 'package:webox/ui_components/screens/card_payment_screen.dart';
import 'package:webox/ui_components/screens/change_password_screen.dart';
import 'package:webox/ui_components/screens/deliverer_form_screen.dart';
import 'package:webox/ui_components/screens/deliverer_list_screen.dart';
import 'package:webox/ui_components/screens/edit_account_information_screen.dart';
import 'package:webox/ui_components/screens/make_order_screen.dart';
import 'package:webox/ui_components/screens/orders_list_screen.dart';
import 'package:webox/ui_components/screens/payment_result_screen.dart';
import 'package:webox/ui_components/screens/reset_password_screen.dart';
import 'package:webox/ui_components/screens/shopping_cart_screen.dart';
import 'package:webox/ui_components/screens/storage_lot_form_screen.dart';
import 'package:webox/ui_components/screens/storage_lot_info_screen.dart';
import 'package:webox/ui_components/screens/storage_lot_list_screen.dart';
import 'package:webox/ui_components/screens/storage_replenishment_screen.dart';
import 'package:webox/ui_components/screens/update_email_screen.dart';
import 'package:webox/ui_components/screens/verification_code_screen.dart';
import 'package:webox/ui_components/screens/laptop_form_screen.dart';
import 'package:webox/ui_components/screens/laptop_info_screen.dart';
import 'package:webox/ui_components/screens/login_screen.dart';
import 'package:webox/ui_components/screens/main_screen.dart';
import 'package:webox/ui_components/screens/personal_cabinet_screen.dart';
import 'package:webox/ui_components/screens/personal_reviews_screen.dart';
import 'package:webox/ui_components/screens/register_screen.dart';
import 'package:webox/ui_components/screens/restore_password_screen.dart';
import 'package:webox/ui_components/screens/review_form_screen.dart';

final routes = <String, WidgetBuilder>{
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => MainScreen(),
  '/laptops/form': (context) => LaptopFormScreen(),
  '/laptops/info': (context) => LaptopInfoScreen(),
  '/reviews/form': (context) => ReviewFormScreen(),
  '/reviews/user': (context) => PersonalReviewsScreen(),
  '/password/restore': (context) => RestorePasswordScreen(),
  '/personal-cabinet': (context) => PersonalCabinetScreen(),
  '/edit-account-information': (context) => EditAccountInformationScreen(),
  '/verification': (context) => VerificationCodeScreen(),
  '/update-email': (context) => UpdateEmailScreen(),
  '/change-password': (context) => ChangePasswordScreen(),
  '/reset-password': (context) => ResetPasswordScreen(),
  '/deliverer/list': (context) => DelivererListScreen(),
  '/deliverer/form': (context) => DelivererFormScreen(),
  '/storage-lots/form': (context) => StorageLotFormScreen(),
  '/storage-lots/list': (context) => StorageLotListScreen(),
  '/storage-lots/info': (context) => StorageLotInfoScreen(),
  '/storage-lots/replenish': (context) => StorageReplenishmentScreen(),
  '/shopping-cart': (context) => ShoppingCartScreen(),
  '/make-order': (context) => MakeOrderScreen(),
  '/card-payment': (context) => CardPaymentScreen(),
  '/payment-result': (context) => PaymentResultScreen(),
  '/orders/list': (context) => OrdersListScreen(),
};
