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
  Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// String methods
  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
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
  Future<void> saveStringList(String key, List<String>? value) async {
    await _prefs.setStringList(key, value ?? []);
  }

  Future<void> addValueToStringList(String key, String value) async {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (!list.contains(value)) {
      list.add(value);
      await _prefs.setStringList(key, list);
    }
  }

  Future<void> updateValueToStringList(String key, String oldValue, String newValue) async {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (!list.contains(oldValue)) {
      throw FlutterError("Error on try to updateValueToStringList because does not exist the oldValue indicated");
    }
    int index = list.indexOf(oldValue);
    list.remove(oldValue);
    list.insert(index, newValue);
    await _prefs.setStringList(key, list);
  }

  Future<void> removeValueToStringList(String key, String value) async {
    List<String> list = _prefs.getStringList(key) ?? [];
    if (list.contains(value)) {
      list.remove(value);
      await _prefs.setStringList(key, list);
    }
  }

  List<String> getStringList(String key) {
    return _prefs.getStringList(key) ?? [];
  }
}
