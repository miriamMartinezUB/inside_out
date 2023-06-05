import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

enum EventType { thoughtDiary, forgivenessDiet, prioritisingPrinciples }

extension EventTypeFromString on String {
  EventType getEventType() {
    for (EventType type in EventType.values) {
      if (type.name == this) {
        return type;
      }
    }
    throw FlutterError("Does not exist an event type that correspond to $this");
  }
}

abstract class Event {
  final String id;
  final String userId;
  final String title;
  final DateTime dateTime;
  final EventType type;

  Event({
    required this.id,
    required this.userId,
    required this.title,
    required this.dateTime,
    required this.type,
  });

  factory Event.fromDoc(DocumentSnapshot doc) {
    EventType type = EventTypeFromString(doc['type']).getEventType();
    switch (type) {
      case EventType.thoughtDiary:
        return EventThoughtDiary.fromDoc(doc);
      case EventType.forgivenessDiet:
        return EventForgivenessDiet.fromDoc(doc);
      case EventType.prioritisingPrinciples:
        return EventPrioritisingPrinciples.fromDoc(doc);
    }
  }

  Map<String, dynamic> toJson();
}

class EventThoughtDiary extends Event {
  final List emotions;
  final List bodySensations;
  final List behaviours;
  final String reason;
  final List? thingsToChange;
  final List? thingsToKeep;
  final List? thingsToLearn;
  final List? thingsToPrevent;

  EventThoughtDiary({
    required String id,
    required String userId,
    required DateTime dateTime,
    required this.emotions,
    required this.bodySensations,
    required this.behaviours,
    required this.reason,
    this.thingsToChange,
    this.thingsToKeep,
    this.thingsToLearn,
    this.thingsToPrevent,
  }) : super(
          id: id,
          userId: userId,
          title: 'event_thought_diary',
          dateTime: dateTime,
          type: EventType.thoughtDiary,
        );

  factory EventThoughtDiary.fromDoc(DocumentSnapshot doc) {
    return EventThoughtDiary(
      id: doc['id'],
      userId: doc['userId'],
      dateTime: DateTime.parse(doc['dateTime']),
      emotions: doc['emotions'],
      bodySensations: doc['bodySensations'],
      behaviours: doc['behaviours'],
      reason: doc['reason'],
      thingsToChange: doc['thingsToChange'],
      thingsToKeep: doc['thingsToKeep'],
      thingsToLearn: doc['thingsToLearn'],
      thingsToPrevent: doc['thingsToPrevent'],
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'emotions': emotions,
        'bodySensations': bodySensations,
        'behaviours': behaviours,
        'reason': reason,
        'thingsToChange': thingsToChange,
        'thingsToKeep': thingsToKeep,
        'thingsToLearn': thingsToLearn,
        'thingsToPrevent': thingsToPrevent,
      };
}

class EventForgivenessDiet extends Event {
  final List forgivenessPhrases;

  EventForgivenessDiet({
    required String id,
    required String userId,
    required DateTime dateTime,
    required this.forgivenessPhrases,
  }) : super(
          id: id,
          userId: userId,
          title: 'event_forgiveness_diet',
          dateTime: dateTime,
          type: EventType.forgivenessDiet,
        );

  factory EventForgivenessDiet.fromDoc(DocumentSnapshot doc) {
    return EventForgivenessDiet(
      id: doc['id'],
      userId: doc['userId'],
      dateTime: DateTime.parse(doc['dateTime']),
      forgivenessPhrases: doc['forgivenessPhrases'],
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'forgivenessPhrases': forgivenessPhrases,
      };
}

class EventPrioritisingPrinciples extends Event {
  final List principles;
  final List values;

  EventPrioritisingPrinciples({
    required String id,
    required String userId,
    required DateTime dateTime,
    required this.principles,
    required this.values,
  }) : super(
          id: id,
          userId: userId,
          title: 'event_prioritising_principles',
          dateTime: dateTime,
          type: EventType.prioritisingPrinciples,
        );

  factory EventPrioritisingPrinciples.fromDoc(DocumentSnapshot doc) {
    return EventPrioritisingPrinciples(
      id: doc['id'],
      userId: doc['userId'],
      dateTime: DateTime.parse(doc['dateTime']),
      principles: doc['principles'],
      values: doc['values'],
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'principles': principles,
        'values': values,
      };
}
