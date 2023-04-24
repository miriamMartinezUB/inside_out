import 'package:inside_out/domain/question/question.dart';

class AppForm {
  final String id;
  final String name;
  final List<Question> questions;
  bool isByPerson;

  AppForm({
    required this.id,
    required this.name,
    required this.questions,
    this.isByPerson = false,
  });

  AppForm copyWith({List<Question>? questions}) => AppForm(
        id: id,
        name: name,
        questions: questions ?? this.questions,
      );
}
