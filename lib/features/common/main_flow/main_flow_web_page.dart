import 'package:flutter/material.dart';
import 'package:inside_out/features/common/main_flow/main_flow_provider.dart';
import 'package:inside_out/features/home/home_page.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class MainFlowPage extends StatefulWidget {
  const MainFlowPage({Key? key}) : super(key: key);

  @override
  State<MainFlowPage> createState() => _MainFlowPageState();
}

class _MainFlowPageState extends State<MainFlowPage> {
  late ThemeService themeService;
  late LanguageService languageService;
  late MainFLowProvider mainFLowProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeService = Provider.of<ThemeService>(context);
    languageService = Provider.of<LanguageService>(context);
    mainFLowProvider = MainFLowProvider(
      themeService: themeService,
      languageService: languageService,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainFLowProvider>(
      create: (context) => mainFLowProvider,
      child: Consumer<MainFLowProvider>(
        builder: (context, mainFLowProvider, child) {
          return HomePage(
            key: Key(const Uuid().v4()),
          );
        },
      ),
    );
  }
}
