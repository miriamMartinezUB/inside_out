import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/features/settings/questions.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';

class SettingsProvider extends ChangeNotifier {
  final LanguageService languageService;
  final ThemeService themeService;

  SingleSelectionQuestion _selectLanguageQuestion = selectLanguageQuestionForm;
  SingleSelectionQuestion _selectThemeQuestion = selectThemeQuestionForm;
  FreeTextQuestion _sendFeedbackQuestion = sendFeedbackQuestionForm;
  String _feedback = '';

  SettingsProvider({
    required this.languageService,
    required this.themeService,
  }) {
    _setSelectLanguageQuestion(languageService.currentLanguageCode);
    _setSelectThemeQuestion(themeService.themePreference.name);
  }

  set feedback(String newFeedback) => _feedback = newFeedback;

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

  FreeTextQuestion get sendFeedbackQuestion => _sendFeedbackQuestion;

  void sendFeedback() {
    //TODO send email
    // Clear feedback
    _setSendFeedbackQuestion('');
    notifyListeners();
  }

  void _setSendFeedbackQuestion(String value) => _sendFeedbackQuestion = _sendFeedbackQuestion.copyWith(value: value);

  void removeAllData() {
    //TODO
  }

  void deleteAccount() {
    //TODO
  }
}
