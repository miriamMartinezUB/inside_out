import 'package:inside_out/domain/question/question.dart';

class SingleSelectionQuestion extends Question {
  final List<String> values;
  final String? selectedValue;

  SingleSelectionQuestion({
    required this.values,
    required String title,
    required String id,
    this.selectedValue,
    String? subtitle,
    bool mandatory = true,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          mandatory: mandatory,
        );

  SingleSelectionQuestion copyWith({
    String? selectedValue,
  }) =>
      SingleSelectionQuestion(
        id: id,
        title: title,
        values: values,
        selectedValue: selectedValue ?? this.selectedValue,
        subtitle: subtitle,
        mandatory: mandatory,
      );
}
