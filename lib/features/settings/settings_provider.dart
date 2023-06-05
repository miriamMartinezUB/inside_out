import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/features/settings/questions.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/user_storage.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/storage_keys.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsProvider extends ChangeNotifier {
  final LanguageService languageService;
  final ThemeService themeService;
  final AuthService authService;
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;

  SingleSelectionQuestion _selectLanguageQuestion = selectLanguageQuestionForm;
  SingleSelectionQuestion _selectThemeQuestion = selectThemeQuestionForm;
  late final UserStorage _userStorage;

  SettingsProvider({
    required this.languageService,
    required this.themeService,
    required this.authService,
    required this.firebaseService,
    required this.localeStorageService,
  }) {
    _setSelectLanguageQuestion(languageService.currentLanguageCode);
    _setSelectThemeQuestion(themeService.themePreference.name);
    _userStorage = UserStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
  }

  SingleSelectionQuestion get selectLanguageQuestion => _selectLanguageQuestion;

  Future<void> setLanguage(String value) async {
    _setSelectLanguageQuestion(value);
    await languageService.changeCurrentLocale(value);
    User user = User.fromJson(jsonDecode(localeStorageService.getString(StorageKeys.keyUser)));
    await _userStorage.update(user.copyWith(locale: value));
    notifyListeners();
  }

  Future<void> _setSelectLanguageQuestion(String value) async {
    _selectLanguageQuestion = _selectLanguageQuestion.copyWith(selectedValue: value);
  }

  SingleSelectionQuestion get selectThemeQuestion => _selectThemeQuestion;

  Future<void> setTheme(String value) async {
    _setSelectThemeQuestion(value);
    ThemePreference newThemePreference =
        value == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark;
    themeService.setTheme(newThemePreference);
    User user = User.fromJson(jsonDecode(localeStorageService.getString(StorageKeys.keyUser)));
    await _userStorage.update(user.copyWith(themePreference: value));
    notifyListeners();
  }

  void _setSelectThemeQuestion(String value) {
    _selectThemeQuestion = _selectThemeQuestion.copyWith(selectedValue: value);
  }

  Future<void> sendEmail() async {
    String urlString = 'mailto:miriam.app.service@gmail.com';
    if (await canLaunchUrlString(urlString)) {
      launchUrlString(urlString);
    } else {
      throw FlutterError('Invalid url');
    }
  }

  Future<void> logout() async {
    await authService.logout();
  }

  Future<void> deleteAccount() async {
    await authService.deleteAccount();
  }
}
