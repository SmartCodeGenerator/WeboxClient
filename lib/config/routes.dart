import 'package:webox/ui_components/login_screen.dart';
import 'package:webox/ui_components/main_screen.dart';
import 'package:webox/ui_components/register_screen.dart';

final routes = {
  '/login': (context) => LoginScreen(),
  '/register': (context) => RegisterScreen(),
  '/': (context) => MainScreen(),
};
