import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/infrastructure_setup.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/navigation/router.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InfrastructureSetup infrastructureSetup = InfrastructureSetup();

  await infrastructureSetup.initializeSetupServices();

  final delegate = infrastructureSetup.languageService.delegate;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) {
    runApp(
      LocalizedApp(
        delegate,
        MyApp(
          infrastructureSetup,
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  final InfrastructureSetup infrastructureSetup;

  const MyApp(
    this.infrastructureSetup, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LanguageService languageService = infrastructureSetup.languageService;
    return MultiProvider(
      providers: infrastructureSetup.getProviders(context),
      child: MaterialApp(
        title: translate('app_name'),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          languageService.delegate,
        ],
        supportedLocales: languageService.supportedLocales,
        locale: languageService.currentLocale,
        theme: ThemeData(
          primarySwatch: PaletteMaterialColors.primary,
        ),
        initialRoute: Routes.initialRoute,
        onGenerateRoute: InsideOutRouter.generateRoute,
        navigatorKey: infrastructureSetup.navigationService.navigatorKey,
      ),
    );
  }
}
