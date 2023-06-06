class ActivityAnswer {
  final String activityId;
  final List<Answer> answers;

  ActivityAnswer({
    required this.activityId,
    required this.answers,
  });
}

class Answer {
  final String questionId;
  final dynamic answer;
  final dynamic answerValue;

  Answer({
    required this.questionId,
    required this.answer,
    this.answerValue,
  });
}
