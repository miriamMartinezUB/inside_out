import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/activity_answer.dart';
import 'package:inside_out/domain/user.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/temporary_activities_storage.dart';
import 'package:inside_out/resources/storage_keys.dart';
import 'package:inside_out/utils/temporary_activities_service.dart';
import 'package:inside_out/utils/thought_diary_activity_service.dart';
import 'package:table_calendar/table_calendar.dart';

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
    _user = User.fromJson(jsonDecode(localeStorageService.getString(StorageKeys.keyUser)));
    _temporaryActivitiesStorage =
        TemporaryActivitiesStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _temporaryActivitiesService = TemporaryActivitiesService(firebaseService, localeStorageService);
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

  Future<void> onFinishForgiveness(ActivityAnswer activityAnswer, String reason, TemporaryActivity activity) async {
    await _temporaryActivitiesService.saveForgivenessDiet(activityAnswer, reason);
    await _temporaryActivitiesService.markAsDone(activity);
  }

  Future<void> onFinishPrioritisationPrinciples(ActivityAnswer activityAnswer, TemporaryActivity activity) async {
    await _temporaryActivitiesService.savePrinciplesAndValues(activityAnswer);
    await _temporaryActivitiesService.markAsDone(activity);
  }
}
