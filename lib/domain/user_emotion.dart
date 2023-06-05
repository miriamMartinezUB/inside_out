import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inside_out/domain/emotion.dart';

class UserEmotion {
  final String id;
  final String userId;
  final Emotion emotion;
  final List bodySensations;
  final List behaviours;

  UserEmotion({
    required this.id,
    required this.userId,
    required this.emotion,
    required this.bodySensations,
    required this.behaviours,
  });

  UserEmotion copyWith({String? id, List? bodySensations, List? behaviours}) {
    return UserEmotion(
      id: id ?? this.id,
      userId: userId,
      emotion: emotion,
      bodySensations: bodySensations ?? this.bodySensations,
      behaviours: behaviours ?? this.behaviours,
    );
  }

  factory UserEmotion.fromDoc(DocumentSnapshot doc) {
    return UserEmotion(
      id: doc['id'],
      userId: doc['userId'],
      emotion: EmotionFromString(doc['emotion']).getEmotion(),
      bodySensations: doc['bodySensations'],
      behaviours: doc['behaviours'],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'emotion': emotion.name,
        'bodySensations': bodySensations,
        'behaviours': behaviours,
      };
}
