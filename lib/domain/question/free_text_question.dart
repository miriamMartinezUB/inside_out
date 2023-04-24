import 'package:inside_out/domain/question/question.dart';

class FreeTextQuestion extends Question {
  final String? hint;
  final String? value;
  final bool longText;

  FreeTextQuestion({
    required String title,
    required String id,
    this.value,
    this.hint,
    String? subtitle,
    this.longText = false,
    bool mandatory = true,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          mandatory: mandatory,
        );

  FreeTextQuestion copyWith({String? value}) => FreeTextQuestion(
        id: id,
        title: title,
        hint: hint,
        value: value,
        subtitle: subtitle,
        mandatory: mandatory,
      );
}
