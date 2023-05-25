import 'package:flutter/cupertino.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class InfrastructureSetup {
  late LocaleStorageService localeStorageService;
  late FirebaseService firebaseService;
  late AuthService authService;
  late LanguageService languageService;
  late ThemeService themeService;
  late NavigationService navigationService;

  InfrastructureSetup() {
    localeStorageService = LocaleStorageService();
    firebaseService = FirebaseService();
    authService = AuthService(firebaseService: firebaseService, storageService: localeStorageService);
    languageService = LanguageService();
    themeService = ThemeService(localeStorageService);
    navigationService = NavigationService(authService);
  }

  /// Warning: the order is important, to keep the dependencies right
  Future<void> initializeSetupServices() async {
    await localeStorageService.init();
    await firebaseService.init();
    await authService.init();
    await languageService.initDelegate();
    themeService.init();
  }

  /// List of providers that need to be accessed in all the application, each one is related
  /// to one service of infrastructure directory
  List<SingleChildWidget> getProviders(BuildContext context) => [
        Provider<LocaleStorageService>(
          create: (context) => localeStorageService,
        ),
        Provider<FirebaseService>(
          create: (context) => firebaseService,
        ),
        Provider<AuthService>(
          create: (context) => authService,
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
