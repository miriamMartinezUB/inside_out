import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Int methods
  void saveInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }
}
