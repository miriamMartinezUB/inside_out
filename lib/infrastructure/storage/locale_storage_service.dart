import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorageService {
  late final SharedPreferences _prefs;
  late final FlutterSecureStorage _secureStorage;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _secureStorage = const FlutterSecureStorage();
  }

  /// Int methods
  void saveInt(String key, int value) {
    _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// String methods
  void saveString(String key, String value) {
    _prefs.setString(key, value);
  }

  String getString(String key) {
    return _prefs.getString(key) ?? '';
  }

  /// String encrypted methods
  Future<void> saveEncryptString(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String> getDecryptString(String key) async {
    return await _secureStorage.read(key: key) ?? '';
  }

  /// StringList methods
  void saveStringList(String key, List<String>? value) {
    _prefs.setStringList(key, value ?? []);
  }

  void addValueToStringList(String key, String value) {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (!list.contains(value)) {
      list.add(value);
      _prefs.setStringList(key, list);
    }
  }

  void updateValueToStringList(String key, String oldValue, String newValue) {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (!list.contains(oldValue)) {
      throw FlutterError("Error on try to updateValueToStringList because does not exist the oldValue indicated");
    }
    int index = list.indexOf(oldValue);
    list.remove(oldValue);
    list.insert(index, newValue);
    _prefs.setStringList(key, list);
  }

  void removeValueToStringList(String key, String value) {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (list.contains(value)) {
      list.remove(value);
      _prefs.setStringList(key, list);
    }
  }

  List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }
}
