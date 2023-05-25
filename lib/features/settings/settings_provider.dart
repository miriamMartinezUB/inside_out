import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/features/settings/questions.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsProvider extends ChangeNotifier {
  final LanguageService languageService;
  final ThemeService themeService;
  final AuthService authService;

  SingleSelectionQuestion _selectLanguageQuestion = selectLanguageQuestionForm;
  SingleSelectionQuestion _selectThemeQuestion = selectThemeQuestionForm;

  SettingsProvider({
    required this.languageService,
    required this.themeService,
    required this.authService,
  }) {
    _setSelectLanguageQuestion(languageService.currentLanguageCode);
    _setSelectThemeQuestion(themeService.themePreference.name);
  }

  SingleSelectionQuestion get selectLanguageQuestion => _selectLanguageQuestion;

  Future<void> setLanguage(String value) async {
    _setSelectLanguageQuestion(value);
    await languageService.changeCurrentLocale(value);
    notifyListeners();
  }

  Future<void> _setSelectLanguageQuestion(String value) async {
    _selectLanguageQuestion = _selectLanguageQuestion.copyWith(selectedValue: value);
  }

  SingleSelectionQuestion get selectThemeQuestion => _selectThemeQuestion;

  void setTheme(String value) {
    _setSelectThemeQuestion(value);
    ThemePreference newThemePreference =
        value == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark;
    themeService.setTheme(newThemePreference);
    notifyListeners();
  }

  void _setSelectThemeQuestion(String value) {
    _selectThemeQuestion = _selectThemeQuestion.copyWith(selectedValue: value);
  }

  Future<void> sendEmail() async {
    String urlString = 'mailto:miriam.app.service@gmail.com';
    if (await canLaunchUrlString(urlString)) {
      launchUrlString(urlString);
    }else{
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
