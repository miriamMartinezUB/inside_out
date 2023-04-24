abstract class Question {
  final String id;
  final String title;
  final String? subtitle;
  final bool mandatory;

  Question({
    required this.id,
    required this.title,
    this.subtitle,
    this.mandatory = true,
  });
}
