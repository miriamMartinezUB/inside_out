import 'package:inside_out/domain/content/simple_text.dart';
import 'package:inside_out/domain/question/index.dart';

class InformationQuestion extends Question {
  final String? imagePath;
  final List<SimpleText>? content;

  InformationQuestion({
    this.imagePath,
    this.content,
    String? title,
    required String id,
    String? subtitle,
    bool mandatory = true,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          mandatory: mandatory,
        );

  InformationQuestion copyWith({String? subtitle}) => InformationQuestion(
        id: id,
        title: title,
        subtitle: subtitle ?? this.subtitle,
        mandatory: mandatory,
        imagePath: imagePath,
        content: content,
      );

  @override
  bool get isValid => true;

  @override
  get answer => null;
}
