import 'package:flutter/cupertino.dart';
import 'package:inside_out/features/common/main_flow/main_flow_item_id.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';

class MainFLowProvider extends ChangeNotifier {
  final ThemeService themeService;
  final LanguageService languageService;

  MainFLowProvider({required this.themeService, required this.languageService}) {
    themeService.themeChange.stream.distinct().listen((themeChange) {
      if (themeChange) {
        themeService.themeChange.add(false);
        notifyListeners();
      }
    });
    languageService.languageChange.stream.distinct().listen((languageChange) {
      if (languageChange) {
        languageService.languageChange.add(false);
        notifyListeners();
      }
    });
  }

  int _itemId = MainFlowItemId.home;

  int get currentItemId => _itemId;

  set currentItemId(int itemId) {
    _itemId = itemId;
    notifyListeners();
  }

}
