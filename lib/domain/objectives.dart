import 'package:cloud_firestore/cloud_firestore.dart';

class Objectives {
  final String id;
  final String userId;
  final List? thingsToChange;
  final List? thingsToKeep;
  final List? thingsToLearn;
  final List? thingsToPrevent;

  Objectives({
    required this.id,
    required this.userId,
    this.thingsToChange,
    this.thingsToKeep,
    this.thingsToLearn,
    this.thingsToPrevent,
  });

  Objectives copyWith({
    String? id,
    List? thingsToChange,
    List? thingsToKeep,
    List? thingsToLearn,
    List? thingsToPrevent,
  }) {
    return Objectives(
      id: id ?? this.id,
      userId: userId,
      thingsToChange: thingsToChange ?? this.thingsToChange,
      thingsToKeep: thingsToKeep ?? this.thingsToKeep,
      thingsToLearn: thingsToLearn ?? this.thingsToLearn,
      thingsToPrevent: thingsToPrevent ?? this.thingsToPrevent,
    );
  }

  factory Objectives.fromDoc(DocumentSnapshot doc) {
    return Objectives(
      id: doc['id'],
      userId: doc['userId'],
      thingsToChange: doc['thingsToChange'],
      thingsToKeep: doc['thingsToKeep'],
      thingsToLearn: doc['thingsToLearn'],
      thingsToPrevent: doc['thingsToPrevent'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'thingsToChange': thingsToChange,
        'thingsToKeep': thingsToKeep,
        'thingsToLearn': thingsToLearn,
        'thingsToPrevent': thingsToPrevent,
      };
}
