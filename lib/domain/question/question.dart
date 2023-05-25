class Question {
  final String id;
  final String title;
  final String? imagePath;
  final String? subtitle;
  final bool mandatory;
  final List<SimpleText>? content;

  Question({
    required this.id,
    required this.title,
    this.imagePath,
    this.subtitle,
    this.content,
    this.mandatory = true,
  });
}

class SimpleText {
  final String text;
  final List<BulletPoint>? bulletPoints;

  SimpleText(this.text, {this.bulletPoints});
}

class BulletPoint {
  final String text;
  final List<String>? children;

  BulletPoint(this.text, {this.children});
}
