import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:inside_out/encryptor.dart';

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
      emotions: (doc['emotions'] as List).map((emotion) => Encryptor.decrypt64(emotion)).toList(),
      bodySensations:
          (doc['bodySensations'] as List).map((bodySensation) => Encryptor.decrypt64(bodySensation)).toList(),
      behaviours: (doc['behaviours'] as List).map((behaviour) => Encryptor.decrypt64(behaviour)).toList(),
      reason: Encryptor.decrypt64(doc['reason']),
      thingsToChange: (doc['thingsToChange'] as List).map((change) => Encryptor.decrypt64(change)).toList(),
      thingsToKeep: (doc['thingsToKeep'] as List).map((keep) => Encryptor.decrypt64(keep)).toList(),
      thingsToLearn: (doc['thingsToLearn'] as List).map((learn) => Encryptor.decrypt64(learn)).toList(),
      thingsToPrevent: (doc['thingsToPrevent'] as List).map((prevent) => Encryptor.decrypt64(prevent)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'emotions': emotions.map((emotion) => Encryptor.encrypt64(emotion)).toList(),
        'bodySensations': bodySensations.map((bodySensation) => Encryptor.encrypt64(bodySensation)).toList(),
        'behaviours': behaviours.map((behaviour) => Encryptor.encrypt64(behaviour)).toList(),
        'reason': Encryptor.encrypt64(reason),
        'thingsToChange': (thingsToChange ?? []).map((change) => Encryptor.encrypt64(change)).toList(),
        'thingsToKeep': (thingsToKeep ?? []).map((keep) => Encryptor.encrypt64(keep)).toList(),
        'thingsToLearn': (thingsToLearn ?? []).map((learn) => Encryptor.encrypt64(learn)).toList(),
        'thingsToPrevent': (thingsToPrevent ?? []).map((prevent) => Encryptor.encrypt64(prevent)).toList(),
      };
}

class EventForgivenessDiet extends Event {
  final String reason;
  final String forgivenessPhrases;

  EventForgivenessDiet({
    required String id,
    required String userId,
    required DateTime dateTime,
    required this.reason,
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
      reason: Encryptor.decrypt64(doc['reason']),
      forgivenessPhrases: Encryptor.decrypt64(doc['forgivenessPhrases']),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'reason': Encryptor.encrypt64(reason),
        'forgivenessPhrases': Encryptor.encrypt64(forgivenessPhrases),
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
      principles: (doc['principles'] as List).map((principle) => Encryptor.decrypt64(principle)).toList(),
      values: (doc['values'] as List).map((value) => Encryptor.decrypt64(value)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'principles': principles.map((principle) => Encryptor.encrypt64(principle)).toList(),
        'values': values.map((value) => Encryptor.encrypt64(value)).toList(),
      };
}
