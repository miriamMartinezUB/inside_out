import 'package:flutter/material.dart';
import 'package:inside_out/features/home_page.dart';
import 'package:inside_out/features/sing_up/login_page.dart';
import 'package:inside_out/resources/routes.dart';

class InsideOutRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      default:
        return MaterialPageRoute(builder: (context) => const LoginPage());
    }
  }
}
