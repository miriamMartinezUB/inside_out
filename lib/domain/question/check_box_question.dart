import 'package:inside_out/domain/question/question.dart';

class CheckBoxQuestion extends Question {
  final List<ValueCheckBox>? values;
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
    List<ValueCheckBox>? values,
  }) =>
      CheckBoxQuestion(
        id: id,
        title: title!,
        values: values ?? this.values,
        selectedValues: selectedValues ?? this.selectedValues,
        subtitle: subtitle,
        mandatory: mandatory,
      );

  List get _selectedSaveValue {
    if (values == null) return [];
    List<String> selectedSaveValue = [];
    for (var value in selectedValues ?? []) {
      ValueCheckBox valueCheckBox = values!.firstWhere((element) => element.value == value);
      if (valueCheckBox.saveValues != null) {
        selectedSaveValue.addAll(valueCheckBox.saveValues!);
      } else {
        selectedSaveValue.add(value);
      }
    }
    return selectedSaveValue.toSet().toList();
  }

  @override
  bool get isValid => (mandatory && selectedValues != null && selectedValues!.isNotEmpty) || !mandatory;

  @override
  get answer {
    return _selectedSaveValue.isEmpty ? null : _selectedSaveValue;
  }
}

class ValueCheckBox {
  final String value;
  final String? hint;
  final List<String>? saveValues;

  ValueCheckBox(this.value, {this.hint, this.saveValues});
}
