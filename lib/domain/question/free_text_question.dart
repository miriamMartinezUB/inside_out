import 'package:inside_out/domain/question/question.dart';

class FreeTextQuestion extends Question {
  final String? hint;
  final String? value;
  final bool longText;
  final bool isObscureText;
  final bool readOnly;
  final int? maxLength;
  final int? minLines;
  final bool canCopyAndPaste;

  FreeTextQuestion({
    required String id,
    this.value,
    this.hint,
    String? title,
    String? subtitle,
    this.readOnly = false,
    this.longText = false,
    bool mandatory = true,
    this.isObscureText = false,
    this.canCopyAndPaste = true,
    this.maxLength,
    this.minLines,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          mandatory: mandatory,
        );

  int get numLines => value == null ? 0 : '\n'.allMatches(value!).length + 1;

  FreeTextQuestion copyWith({String? value, String? subtitle}) => FreeTextQuestion(
        id: id,
        title: title,
        hint: hint,
        value: value,
        subtitle: subtitle ?? this.subtitle,
        mandatory: mandatory,
        isObscureText: isObscureText,
        longText: longText,
        maxLength: maxLength,
        minLines: minLines,
        canCopyAndPaste: canCopyAndPaste,
        readOnly: readOnly,
      );

  @override
  bool get isValid {
    if (mandatory && (value == null || value!.isEmpty)) return false;
    if (minLines != null && numLines < minLines!) return false;
    return true;
  }

  @override
  String get errorMessage {
    if (minLines != null && numLines < minLines!) return 'min_lines_error';
    return super.errorMessage;
  }

  @override
  get answer => value;
}
