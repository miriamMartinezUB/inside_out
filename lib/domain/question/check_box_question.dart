import 'package:inside_out/domain/question/question.dart';

class CheckBoxQuestion extends Question {
  final List<String>? values;
  final List? selectedValues;

  CheckBoxQuestion({
    required String title,
    required String id,
    this.values,
    this.selectedValues,
    String? subtitle,
    bool mandatory = true,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          mandatory: mandatory,
        );

  CheckBoxQuestion copyWith({
    List? selectedValues,
    List<String>? values,
  }) =>
      CheckBoxQuestion(
        id: id,
        title: title,
        values: values ?? this.values,
        selectedValues: selectedValues ?? this.selectedValues,
        subtitle: subtitle,
        mandatory: mandatory,
      );
}
