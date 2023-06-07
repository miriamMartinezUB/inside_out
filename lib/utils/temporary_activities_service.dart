import 'dart:convert';

import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/activity_answer.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/event_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/temporary_activities_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/user_storage.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:inside_out/resources/storage_keys.dart';
import 'package:uuid/uuid.dart';

class TemporaryActivitiesService {
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;

  late final User _user;
  late final UserStorage _userStorage;
  late final EventsStorage _eventsStorage;
  late final TemporaryActivitiesStorage _temporaryActivitiesStorage;

  TemporaryActivitiesService(
    this.firebaseService,
    this.localeStorageService,
  ) {
    _user = User.fromJson(jsonDecode(localeStorageService.getString(StorageKeys.keyUser)));
    _userStorage = UserStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _eventsStorage = EventsStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _temporaryActivitiesStorage =
        TemporaryActivitiesStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
  }

  static AppForm getModifiedPrinciplesAndValuesQuestionValues(
      AppForm principlesAndValuesSelectorQuestions, ActivityStep activityStep) {
    List<String> selectedPrinciples =
        (principlesAndValuesSelectorQuestions.questions.first as CheckBoxQuestion).answer as List<String>;
    List<String> selectedValues =
        (principlesAndValuesSelectorQuestions.questions.last as CheckBoxQuestion).answer as List<String>;

    AppForm form = activityStep.form.copyWith(
      questions: [
        (activityStep.form.questions.first as PrioritisationListQuestion).copyWith(
          values: selectedPrinciples,
        ),
        (activityStep.form.questions.last as PrioritisationListQuestion).copyWith(
          values: selectedValues,
        )
      ],
    );
    return form;
  }

  static AppForm getModifiedForgivenessDietReason(String reason, ActivityStep activityStep) {
    FreeTextQuestion question = activityStep.form.questions.first as FreeTextQuestion;
    AppForm form = activityStep.form.copyWith(
      questions: [
        question.copyWith(subtitle: '$reason\n\n${translate(question.subtitle!)}'),
        activityStep.form.questions.last,
      ],
    );
    return form;
  }

  static AppForm getModifiedForgivenessDietPhrases(String phrases, ActivityStep activityStep) {
    List<Question> questions = activityStep.form.questions;
    InformationQuestion question = questions.first as InformationQuestion;
    questions.removeAt(0);
    questions.insert(0, question.copyWith(subtitle: phrases));
    AppForm form = activityStep.form.copyWith(
      questions: questions,
    );
    return form;
  }

  addActivities(List emotions, {String? reason}) {
    //TODO mirar si nunca he tenido una de tipo principios explicar, si no he tenido ninguna de dieta de perdon explicar
    List<TemporaryActivity> activities = [];
    if (emotions.contains(Emotion.anger.name)) {
      activities.addAll(List.generate(7, (index) {
        return ForgivenessDietActivity(
          id: const Uuid().v4(),
          userId: _user.id,
          activityId: ActivityId.forgivenessDietActivityId,
          currentDay: index + 1,
          reason: reason,
          dateTime: DateTime.now().add(Duration(days: index)),
        );
      }).toList());
    }
    if (emotions.contains(Emotion.sadness.name)) {
      activities.add(TemporaryActivity(
        id: const Uuid().v4(),
        userId: _user.id,
        activityId: ActivityId.prioritisationPrinciplesActivityId,
        dateTime: DateTime.now(),
      ));
    }
    for (var element in activities) {
      _temporaryActivitiesStorage.add(element);
    }
  }

  Future<void> savePrinciplesAndValues(ActivityAnswer principlesAndValuesAnswer) async {
    late final List principles;
    late final List values;
    for (Answer answer in principlesAndValuesAnswer.answers) {
      if (answer.questionId == ActivityStepQuestionId.prioritisationPrinciplesOrder) {
        principles = answer.answer;
      } else if (answer.questionId == ActivityStepQuestionId.prioritisationPrinciplesValuesOrder) {
        values = answer.answer;
      }
    }
    _userStorage.update(_user.copyWith(
      principles: principles,
      values: values,
    ));

    _eventsStorage.add(EventPrioritisingPrinciples(
      id: const Uuid().v4(),
      userId: _user.id,
      dateTime: DateTime.now(),
      principles: principles,
      values: values,
    ));
  }

  Future<void> saveForgivenessDiet(ActivityAnswer forgivenessDietAnswer, String reason) async {
    String forgivenessPhrases = forgivenessDietAnswer.answers
        .firstWhere(
            (element) => element.questionId == ActivityStepQuestionId.forgivenessDietActivityAddForgivenessPhrases)
        .answer;

    _eventsStorage.add(EventForgivenessDiet(
      id: const Uuid().v4(),
      userId: _user.id,
      dateTime: DateTime.now(),
      reason: reason,
      forgivenessPhrases: forgivenessPhrases,
    ));
  }

  Future<void> markAsDone(TemporaryActivity activity) async {
    await _temporaryActivitiesStorage.update(activity.copyWith(isDone: true));
  }
}
