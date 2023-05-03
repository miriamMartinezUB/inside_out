import 'package:inside_out/domain/question/question.dart';

class AppForm {
  final String id;
  final String name;
  final List<Question> questions;

  /// Button Text
  final String actionText;

  AppForm({
    required this.id,
    required this.name,
    required this.questions,
    this.actionText = 'common_save',
  });

  AppForm copyWith({List<Question>? questions}) => AppForm(
        id: id,
        name: name,
        actionText: actionText,
        questions: questions ?? this.questions,
      );
}
