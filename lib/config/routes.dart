import 'package:path/path.dart';
import 'package:webox/ui_components/screens/edit_account_information_screen.dart';
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

final routes = {
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
};
