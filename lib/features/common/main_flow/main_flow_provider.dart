import 'package:flutter/cupertino.dart';
import 'package:inside_out/features/common/main_flow/main_flow_item_id.dart';
import 'package:inside_out/infrastructure/theme_service.dart';

class MainFLowProvider extends ChangeNotifier {
  final ThemeService themeService;

  MainFLowProvider(this.themeService) {
    themeService.themeChange.stream.listen((themChange) {
      if (themChange) {
        themeService.themeChange.add(false);
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
