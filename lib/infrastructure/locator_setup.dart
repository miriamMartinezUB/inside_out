import 'package:get_it/get_it.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/locale_storage_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';

GetIt locator = GetIt.instance;

LocaleStorageService _localeStorageService = LocaleStorageService();
LanguageService _languageService = LanguageService();
ThemeService _themeService = ThemeService(_localeStorageService);

void setupLocator() {
  locator.registerLazySingleton(() => _localeStorageService);
  locator.registerLazySingleton(() => _languageService);
  locator.registerLazySingleton(() => _themeService);
}

/// Warning: the order is important, to keep the dependencies right
Future<void> initializeConfigurationServices() async {
  await _localeStorageService.init();
  await _languageService.initDelegate();
  _themeService.init();
}
