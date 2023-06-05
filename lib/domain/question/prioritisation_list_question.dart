import 'package:inside_out/domain/question/index.dart';

class PrioritisationListQuestion extends Question {
  final List<String>? values;

  PrioritisationListQuestion({
    required String title,
    required String id,
    this.values,
    String? subtitle,
    bool mandatory = false,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          mandatory: mandatory,
        );

  PrioritisationListQuestion copyWith({
    List<String>? values,
  }) =>
      PrioritisationListQuestion(
        id: id,
        title: title!,
        values: values ?? this.values,
        subtitle: subtitle,
        mandatory: mandatory,
      );

  @override
  get answer => values;

  @override
  bool get isValid => true;
}
