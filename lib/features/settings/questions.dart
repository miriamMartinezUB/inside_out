import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/index.dart';
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
    translate(LanguageCode.spanish),
    translate(LanguageCode.catalan),
    translate(LanguageCode.english),
  ],
);

SingleSelectionQuestion selectThemeQuestionForm = SingleSelectionQuestion(
  id: SettingsFormQuestion.selectTheme.name,
  title: 'selected_theme',
  mandatory: false,
  values: [
    translate('light'),
    translate('dark'),
  ],
);
