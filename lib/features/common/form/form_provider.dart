import 'package:flutter/widgets.dart';
import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';

class FormProvider extends ChangeNotifier {
  final String formId;
  late final AppForm _form;

  FormProvider(this.formId) {
    _form = Database().getFormById(formId);
  }

  AppForm get form => _form;

  void setAnswer({required String questionId, dynamic value}) {
    List<Question> questions = [];
    for (Question question in _form.questions) {
      late final Question newQuestion;
      if (question.id == questionId) {
        if (question is FreeTextQuestion) {
          newQuestion = question.copyWith(value: value);
        } else if (question is SingleSelectionQuestion) {
          newQuestion = question.copyWith(selectedValue: value);
        } else if (question is CheckBoxQuestion) {
          List values = question.selectedValues ?? [];
          if (values.contains(value)) {
            values.remove(value);
          } else {
            values.add(value);
          }
          newQuestion = question.copyWith(selectedValues: values);
        }
        questions.add(newQuestion);
      } else {
        questions.add(question);
      }
    }
    _form = _form.copyWith(questions: questions);
    notifyListeners();
  }
}
