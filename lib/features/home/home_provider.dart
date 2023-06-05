import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/activity_answer.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/event_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/temporary_activities_storage.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:inside_out/resources/storage_keys.dart';
import 'package:inside_out/utils/temporary_activities_service.dart';
import 'package:inside_out/utils/thought_diary_activity_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class HomeProvider extends ChangeNotifier {
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;
  late final TemporaryActivitiesService _temporaryActivitiesService;
  late final TemporaryActivitiesStorage _temporaryActivitiesStorage;
  late final User _user;

  HomeProvider({
    required this.firebaseService,
    required this.localeStorageService,
  }) {
    _temporaryActivitiesStorage =
        TemporaryActivitiesStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _user = User.fromJson(jsonDecode(localeStorageService.getString(StorageKeys.keyUser)));
    _temporaryActivitiesService = TemporaryActivitiesService(
      EventsStorage(firebaseService: firebaseService, localeStorageService: localeStorageService),
      _temporaryActivitiesStorage,
      _user.id,
    );
  }

  String get name => _user.firstName;

  Stream<List<TemporaryActivity>> get activities$ => _temporaryActivitiesStorage.all$.distinct().map(
        (event) => event
            .where((element) =>
                isSameDay(element.dateTime, DateTime.now()) ||
                (element.dateTime.isBefore(DateTime.now()) && !element.isDone))
            .toList(),
      );

  Future<void> onFinishThoughtDiary(ActivityAnswer activityAnswer) async {
    final ThoughtDiaryActivityService service = ThoughtDiaryActivityService(
      localeStorageService: localeStorageService,
      firebaseService: firebaseService,
      userId: _user.id,
      thoughtDiaryAnswer: activityAnswer,
    );
    service.saveUserEmotion();
    service.saveObjectives();
    service.saveEvent();
  }

  void onFinishForgiveness(ActivityAnswer activityAnswer) {
    List forgivenessPhrases = activityAnswer.answers
        .firstWhere(
            (element) => element.questionId == ActivityStepQuestionId.forgivenessDietActivityAddForgivenessPhrases)
        .answer;

    _temporaryActivitiesService.saveEvent(EventForgivenessDiet(
      id: const Uuid().v4(),
      userId: _user.id,
      dateTime: DateTime.now(),
      forgivenessPhrases: forgivenessPhrases,
    ));
  }

  void onFinishPrioritisationPrinciples(ActivityAnswer activityAnswer) {
    List principles = activityAnswer.answers
        .firstWhere((element) => element.questionId == ActivityStepQuestionId.prioritisationPrinciplesOrder)
        .answer;
    List values = activityAnswer.answers
        .firstWhere((element) => element.questionId == ActivityStepQuestionId.prioritisationPrinciplesValuesOrder)
        .answer;

    _temporaryActivitiesService.saveEvent(EventPrioritisingPrinciples(
      id: const Uuid().v4(),
      userId: _user.id,
      dateTime: DateTime.now(),
      principles: principles,
      values: values,
    ));
  }
}
