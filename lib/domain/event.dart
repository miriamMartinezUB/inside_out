enum EventType { thoughtDiary, forgivenessDiet, prioritisingPrinciples }

abstract class Event {
  final String id;
  final String title;
  final DateTime dateTime;
  final EventType type;

  Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.type,
  });
}

class EventThoughtDiary extends Event {
  final List<String> emotions;
  final List<String> bodySensations;
  final List<String> behaviours;
  final List<String>? thingsToImprove;
  final String reason;

  EventThoughtDiary({
    required String id,
    required DateTime dateTime,
    required this.emotions,
    required this.bodySensations,
    required this.behaviours,
    this.thingsToImprove,
    required this.reason,
  }) : super(
          id: id,
          title: 'event_thought_diary',
          dateTime: dateTime,
          type: EventType.thoughtDiary,
        );
}

class EventForgivenessDiet extends Event {
  final List<String> forgivenessPhrases;

  EventForgivenessDiet({
    required String id,
    required DateTime dateTime,
    required this.forgivenessPhrases,
  }) : super(
          id: id,
          title: 'event_forgiveness_diet',
          dateTime: dateTime,
          type: EventType.forgivenessDiet,
        );
}

class EventPrioritisingPrinciples extends Event {
  final List<String> principlesAndValues;

  EventPrioritisingPrinciples({
    required String id,
    required DateTime dateTime,
    required this.principlesAndValues,
  }) : super(
          id: id,
          title: 'event_prioritising_principles',
          dateTime: dateTime,
          type: EventType.prioritisingPrinciples,
        );
}
