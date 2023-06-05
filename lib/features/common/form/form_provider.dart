import 'package:flutter/widgets.dart';
import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';

class FormProvider extends ChangeNotifier {
  final String? formId;
  late AppForm? form;

  FormProvider({this.formId, this.form}) {
    if (formId == null && form == null) {
      throw FlutterError('formId and form cannot be null at the same time');
    }
    form ??= Database().getFormById(formId!);
  }

  void setAnswer({required String questionId, dynamic value}) {
    List<Question> questions = [];
    for (Question question in form!.questions) {
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
        } else if (question is PrioritisationListQuestion) {
          newQuestion = question.copyWith(values: value);
        } else if (question is CarrouselQuestion) {
          List<CarrouselQuestionItem> items = [];
          for (CarrouselQuestionItem item in question.items) {
            List values = item.selectedValues ?? [];
            bool valueExistInThisItem = item.values.where((element) => element.value == value).isNotEmpty;
            if (valueExistInThisItem) {
              if (values.contains(value)) {
                values.remove(value);
              } else {
                values.add(value);
              }
            }
            CarrouselQuestionItem newItem = item.copyWith(selectedValues: values);
            items.add(newItem);
          }
          newQuestion = question.copyWith(items: items);
        }
        questions.add(newQuestion);
      } else {
        questions.add(question);
      }
    }
    form = form!.copyWith(questions: questions);
    notifyListeners();
  }
}
