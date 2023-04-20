import 'package:get_it/get_it.dart';
import 'package:inside_out/infrastructure/language_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => LanguageService());
}

Future<void> initializeConfigurationServices() async {
  await locator<LanguageService>().initDelegate();
}
