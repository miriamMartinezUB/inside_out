abstract class Question {
  final String id;
  final String? title;
  final String? subtitle;
  final bool mandatory;

  Question({
    required this.id,
    this.title,
    this.subtitle,
    this.mandatory = true,
  });

  dynamic get answer;

  dynamic get answerValue => null;

  bool get isValid;

  String get errorMessage => 'mandatory_error';
}
