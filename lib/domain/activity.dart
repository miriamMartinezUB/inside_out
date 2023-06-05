import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_out/domain/form.dart';

class Activity {
  final String id;
  final String name;
  final List<ActivityStep> steps;

  Activity({
    required this.id,
    required this.name,
    required this.steps,
  });

  Activity copyWith({List<ActivityStep>? steps}) => Activity(
        id: id,
        name: name,
        steps: steps ?? this.steps,
      );
}

enum TemporaryActivityType { forgivenessDiet, prioritisationPrinciples }

extension TemporaryActivityTypeFromSTring on String {
  getType() {
    if (this == TemporaryActivityType.forgivenessDiet.name) {
      return TemporaryActivityType.forgivenessDiet;
    }
    return TemporaryActivityType.prioritisationPrinciples;
  }
}

class TemporaryActivity {
  final String id;
  final String userId;
  final DateTime dateTime;
  final bool isDone;
  final TemporaryActivityType type;
  final String activityId;

  TemporaryActivity({
    required this.id,
    required this.userId,
    required this.activityId,
    this.type = TemporaryActivityType.prioritisationPrinciples,
    required this.dateTime,
    this.isDone = false,
  });

  TemporaryActivity copyWith({List<ActivityStep>? steps, bool? isDone, DateTime? dateTime}) => TemporaryActivity(
        id: id,
        userId: userId,
        activityId: activityId,
        type: type,
        dateTime: dateTime ?? this.dateTime,
        isDone: isDone ?? this.isDone,
      );

  factory TemporaryActivity.fromJson(Map<String, dynamic> json) {
    TemporaryActivityType type = TemporaryActivityTypeFromSTring(json['type']).getType();
    if (type == TemporaryActivityType.forgivenessDiet) {
      return ForgivenessDietActivity.fromJson(json);
    }
    return TemporaryActivity(
      id: json['id'],
      userId: json['userId'],
      dateTime: DateTime.parse(json['dateTime']),
      type: type,
      isDone: json['isDone'],
      activityId: json['activityId'],
    );
  }

  factory TemporaryActivity.fromDoc(DocumentSnapshot doc) {
    TemporaryActivityType type = TemporaryActivityTypeFromSTring(doc['type']).getType();
    if (type == TemporaryActivityType.forgivenessDiet) {
      return ForgivenessDietActivity.fromDoc(doc);
    }
    return TemporaryActivity(
      id: doc['id'],
      userId: doc['userId'],
      dateTime: DateTime.parse(doc['dateTime']),
      type: type,
      isDone: doc['isDone'],
      activityId: doc['activityId'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'type': type.name,
        'isDone': isDone,
        'activityId': activityId,
      };
}

class ForgivenessDietActivity extends TemporaryActivity {
  final int currentDay;
  final String? reason;

  int get totalDays => 7;

  ForgivenessDietActivity({
    required String id,
    required String userId,
    required String activityId,
    required this.currentDay,
    bool isDone = false,
    required DateTime dateTime,
    this.reason,
  }) : super(
            id: id,
            userId: userId,
            activityId: activityId,
            isDone: isDone,
            dateTime: dateTime,
            type: TemporaryActivityType.forgivenessDiet);

  @override
  ForgivenessDietActivity copyWith({List<ActivityStep>? steps, bool? isDone, String? reason, DateTime? dateTime}) =>
      ForgivenessDietActivity(
        id: id,
        userId: userId,
        activityId: activityId,
        isDone: isDone ?? this.isDone,
        reason: reason ?? this.reason,
        currentDay: currentDay,
        dateTime: dateTime ?? this.dateTime,
      );
  factory ForgivenessDietActivity.fromJson(Map<String, dynamic> json) => ForgivenessDietActivity(
        id: json['id'],
        userId: json['userId'],
        dateTime: DateTime.parse(json['dateTime']),
        isDone: json['isDone'],
        activityId: json['activityId'],
        currentDay: json['currentDay'],
        reason: json['reason'],
      );

  factory ForgivenessDietActivity.fromDoc(DocumentSnapshot doc) {
    return ForgivenessDietActivity(
      id: doc['id'],
      userId: doc['userId'],
      dateTime: DateTime.parse(doc['dateTime']),
      isDone: doc['isDone'],
      activityId: doc['activityId'],
      currentDay: doc['currentDay'],
      reason: doc['reason'],
    );
  }

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'dateTime': dateTime.toString(),
        'isDone': isDone,
        'activityId': activityId,
        'currentDay': currentDay,
        'reason': reason,
        'type': type.name,
      };
}

class ActivityStep {
  final AppForm form;

  ActivityStep({
    required this.form,
  });

  ActivityStep copyWith(AppForm form) => ActivityStep(form: form);
}
