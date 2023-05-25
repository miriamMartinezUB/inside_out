class Question {
  final String id;
  final String title;
  final String? imagePath;
  final String? subtitle;
  final bool mandatory;

  Question({
    required this.id,
    required this.title,
    this.imagePath,
    this.subtitle,
    this.mandatory = true,
  });
}
