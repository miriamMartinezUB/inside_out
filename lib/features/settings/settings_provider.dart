import 'package:flutter/cupertino.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/features/settings/questions.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/languages.dart';

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
    setSelectLanguageQuestion(translate(languageService.currentLanguageCode));
    setSelectThemeQuestion(translate(themeService.themePreference.name));
  }

  set feedback(String newFeedback) => _feedback = newFeedback;

  SingleSelectionQuestion get selectLanguageQuestion => _selectLanguageQuestion;

  void setSelectLanguageQuestion(String value) {
    _selectLanguageQuestion = _selectLanguageQuestion.copyWith(selectedValue: value);
    late String newLocale;
    if (value == translate(LanguageCode.spanish)) {
      newLocale = LanguageCode.spanish;
    } else if (value == translate(LanguageCode.catalan)) {
      newLocale = LanguageCode.catalan;
    } else if (value == translate(LanguageCode.english)) {
      newLocale = LanguageCode.english;
    } else {
      throw FlutterError('The language $value is not implemented for change');
    }
    languageService.changeCurrentLocale(newLocale);
    notifyListeners();
  }

  SingleSelectionQuestion get selectThemeQuestion => _selectThemeQuestion;

  void setSelectThemeQuestion(String value) {
    _selectThemeQuestion = _selectThemeQuestion.copyWith(selectedValue: value);
    ThemePreference newThemePreference =
        value == ThemePreference.light.name ? ThemePreference.light : ThemePreference.dark;
    themeService.setTheme(newThemePreference);
    notifyListeners();
  }

  FreeTextQuestion get sendFeedbackQuestion => _sendFeedbackQuestion;

  void setSendFeedbackQuestion(String value) => _sendFeedbackQuestion = _sendFeedbackQuestion.copyWith(value: value);

  void sendFeedback() {
    //TODO send email
    // Clear feedback
    setSendFeedbackQuestion('');
    notifyListeners();
  }

  void removeAllData() {
    //TODO
  }

  void deleteAccount() {
    //TODO
  }
}
