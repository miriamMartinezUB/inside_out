import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/languages.dart';

enum SettingsFormQuestion {
  selectLanguage,
  selectTheme,
  sendFeedback,
}

FreeTextQuestion sendFeedbackQuestionForm = FreeTextQuestion(
  title: 'send_feedback_title',
  id: SettingsFormQuestion.sendFeedback.name,
  longText: true,
  mandatory: false,
);

SingleSelectionQuestion selectLanguageQuestionForm = SingleSelectionQuestion(
  id: SettingsFormQuestion.selectLanguage.name,
  title: 'selected_language',
  mandatory: false,
  values: [
    LanguageCode.spanish,
    LanguageCode.catalan,
    LanguageCode.english,
  ],
);

SingleSelectionQuestion selectThemeQuestionForm = SingleSelectionQuestion(
  id: SettingsFormQuestion.selectTheme.name,
  title: 'selected_theme',
  mandatory: false,
  values: [
    ThemePreference.light.name,
    ThemePreference.dark.name,
  ],
);
