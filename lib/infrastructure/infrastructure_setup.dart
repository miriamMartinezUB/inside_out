import 'package:flutter/cupertino.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/locale_storage_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class InfrastructureSetup {
  late LocaleStorageService localeStorageService;
  late LanguageService languageService;
  late ThemeService themeService;
  late NavigationService navigationService;

  InfrastructureSetup() {
    localeStorageService = LocaleStorageService();
    languageService = LanguageService();
    themeService = ThemeService(localeStorageService);
    navigationService = NavigationService();
  }

  /// Warning: the order is important, to keep the dependencies right
  Future<void> initializeSetupServices() async {
    await localeStorageService.init();
    await languageService.initDelegate();
    themeService.init();
  }

  /// List of providers that need to be accessed in all the application, each one is related
  /// to one service of infrastructure directory
  List<SingleChildWidget> getProviders(BuildContext context) => [
        Provider<LocaleStorageService>(
          create: (context) => localeStorageService,
        ),
        Provider<LanguageService>(
          create: (context) => languageService,
        ),
        Provider<ThemeService>(
          create: (context) => themeService,
        ),
        Provider<NavigationService>(
          create: (context) => navigationService,
        ),
      ];
}
