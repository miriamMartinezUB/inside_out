class InformationContent {
  final String title;
  final String description;
  final List<InformationCardContent> cards;

  InformationContent({
    required this.title,
    required this.description,
    required this.cards,
  });
}

class InformationCardContent {
  final String title;
  final bool isPrimary;
  final String activityId;

  InformationCardContent({
    required this.title,
    this.isPrimary = false,
    required this.activityId,
  });
}
