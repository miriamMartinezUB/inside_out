import 'package:inside_out/domain/activity_answer.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/domain/objectives.dart';
import 'package:inside_out/domain/user_emotion.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/event_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/objectives_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/temporary_activities_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/user_emotion_storage.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:inside_out/utils/temporary_activities_service.dart';
import 'package:uuid/uuid.dart';

class ThoughtDiaryActivityService {
  final ActivityAnswer thoughtDiaryAnswer;
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;
  final String userId;

  late final UserEmotionStorage _userEmotionStorage;
  late final EventsStorage _eventsStorage;
  late final ObjectivesStorage _objectivesStorage;
  late final TemporaryActivitiesStorage _temporaryActivitiesStorage;

  late final List _emotions;
  late final List _bodySensations;
  late final List _behaviours;
  late final String? _changes;
  late final String? _learn;
  late final String? _keep;
  late final String? _prevent;
  late final String _reason;

  ThoughtDiaryActivityService({
    required this.thoughtDiaryAnswer,
    required this.firebaseService,
    required this.localeStorageService,
    required this.userId,
  }) {
    _userEmotionStorage =
        UserEmotionStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _eventsStorage = EventsStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _objectivesStorage =
        ObjectivesStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _temporaryActivitiesStorage =
        TemporaryActivitiesStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);

    for (Answer answer in thoughtDiaryAnswer.answers) {
      if (answer.questionId == ActivityStepQuestionId.thoughtDiaryEmotionsQuestionId) {
        _emotions = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryBodySensationsQuestionId) {
        _bodySensations = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryBehavioursQuestionId) {
        _behaviours = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryObjectivesChange) {
        _changes = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryObjectivesLearn) {
        _learn = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryObjectivesMaintain) {
        _keep = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryObjectivesPrevent) {
        _prevent = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.thoughtDiaryReasonQuestionId) {
        _reason = answer.answer;
      }
    }
  }

  Future<void> saveUserEmotion() async {
    for (var emotion in _emotions) {
      Emotion finalEmotion = EmotionFromString(emotion).getEmotion();
      List finalBodySensations = [];
      for (String bodySensation in _bodySensations) {
        if (finalEmotion.getBodySensations().contains(bodySensation)) {
          finalBodySensations.add(bodySensation);
        }
      }
      List finalBehaviours = [];
      for (String behaviour in _behaviours) {
        if (finalEmotion.getBehaviours().contains(behaviour)) {
          finalBehaviours.add(behaviour);
        }
      }
      await _userEmotionStorage.put(
        UserEmotion(
          id: const Uuid().v4(),
          userId: userId,
          emotion: finalEmotion,
          bodySensations: finalBodySensations,
          behaviours: finalBehaviours,
        ),
      );
    }
    TemporaryActivitiesService( _eventsStorage,_temporaryActivitiesStorage, userId).addActivities(_emotions);
  }

  Future<void> saveObjectives() async {
    await _objectivesStorage.put(Objectives(
      id: const Uuid().v4(),
      userId: userId,
      thingsToChange: _changes == null ? null : [_changes!],
      thingsToPrevent: _prevent == null ? null : [_prevent!],
      thingsToKeep: _keep == null ? null : [_keep!],
      thingsToLearn: _learn == null ? null : [_learn!],
    ));
  }

  Future<void> saveEvent() async {
    await _eventsStorage.add(EventThoughtDiary(
      id: const Uuid().v4(),
      userId: userId,
      dateTime: DateTime.now(),
      emotions: _emotions,
      bodySensations: _bodySensations,
      behaviours: _behaviours,
      reason: _reason,
      thingsToChange: _changes == null ? null : [_changes!],
      thingsToPrevent: _prevent == null ? null : [_prevent!],
      thingsToKeep: _keep == null ? null : [_keep!],
      thingsToLearn: _learn == null ? null : [_learn!],
    ));
  }
}
