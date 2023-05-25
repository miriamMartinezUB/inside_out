import 'package:flutter/material.dart';
import 'package:inside_out/app.dart';
import 'package:inside_out/features/common/activity/activity_stepper_page.dart';
import 'package:inside_out/features/common/main_flow/main_flow_page.dart';
import 'package:inside_out/features/history/history_page.dart';
import 'package:inside_out/features/information/information_page.dart';
import 'package:inside_out/features/results/results_page.dart';
import 'package:inside_out/features/settings/settings_page.dart';
import 'package:inside_out/features/sign_up/forgot_password_page.dart';
import 'package:inside_out/features/sign_up/login_page.dart';
import 'package:inside_out/features/sign_up/sign_up_page.dart';
import 'package:inside_out/features/welcome_page.dart';
import 'package:inside_out/resources/routes.dart';

class InsideOutRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(builder: (context) => const WelcomePage());
      case Routes.login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case Routes.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (context) => const ForgotPasswordPage());
      case Routes.home:
        return MaterialPageRoute(builder: (context) => const MainFlowPage());
      case Routes.information:
        return MaterialPageRoute(builder: (context) => const InformationPage());
      case Routes.results:
        return MaterialPageRoute(builder: (context) => const ResultsPage());
      case Routes.history:
        return MaterialPageRoute(builder: (context) => const HistoryPage());
      case Routes.settings:
        return MaterialPageRoute(builder: (context) => const SettingsPage());
      case Routes.activity:
        return MaterialPageRoute(
          builder: (context) => ActivityStepperPage(
            activityStepperPageArgs: settings.arguments as ActivityStepperPageArgs,
          ),
        );
      case Routes.initialRoute:
      default:
        return MaterialPageRoute(builder: (context) => const App());
    }
  }
}
