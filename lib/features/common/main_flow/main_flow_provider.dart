import 'package:flutter/cupertino.dart';
import 'package:inside_out/features/common/main_flow/main_flow_item_id.dart';

class MainFLowProvider extends ChangeNotifier {
  int _itemId = MainFlowItemId.home;

  int get currentItemId => _itemId;

  set currentItemId(int itemId) {
    _itemId = itemId;
    notifyListeners();
  }
}
