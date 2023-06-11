import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/resources/storage_keys.dart';

class NavigationService {
  final AuthService authService;
  final LocaleStorageService localeStorageService;

  NavigationService(this.authService, this.localeStorageService);

  final List<String> _navigationStack = [Routes.initialRoute];

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  String get currentRoute => _navigationStack.last;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    _navigationStack.add(routeName);
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replace(String routeName, {dynamic arguments}) {
    _navigationStack.clear();
    _navigationStack.add(routeName);
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  void goBack({dynamic arguments}) {
    if (navigatorKey.currentState!.canPop()) {
      _navigationStack.removeLast();
      navigatorKey.currentState!.pop(arguments);
    }
  }

  void closeView({dynamic arguments}) {
    navigatorKey.currentState!.pop(arguments);
  }

  Future<dynamic> goToInitialRoute() async {
    authService.isAuthenticated$.listen((isAuthenticated) {
      if (isAuthenticated) {
        if (authService.userLoad) {
          replace(Routes.home);
        } else {
          authService.userLoad$.listen((userLoad) {
            if (userLoad) {
              replace(Routes.home);
            }
          });
        }
      } else {
        if (!localeStorageService.getBool(StorageKeys.privacyPolicyAccepted)) {
          replace(Routes.privacyPolicy);
        } else {
          replace(Routes.welcome);
        }
      }
    });
  }
}
