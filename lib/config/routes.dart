import 'package:webox/ui_components/screens/laptop_form_screen.dart';
import 'package:webox/ui_components/screens/laptop_info_screen.dart';
import 'package:webox/ui_components/screens/login_screen.dart';
import 'package:webox/ui_components/screens/main_screen.dart';
import 'package:webox/ui_components/screens/register_screen.dart';

final routes = {
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/home': (context) => MainScreen(),
  '/laptops/form': (context) => LaptopFormScreen(),
  '/laptops/info': (context) => LaptopInfoScreen(),
};
