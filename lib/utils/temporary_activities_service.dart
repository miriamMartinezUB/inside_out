import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/event.dart';
import 'package:inside_out/infrastructure/storage/remote/event_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/temporary_activities_storage.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:uuid/uuid.dart';

class TemporaryActivitiesService {
  final EventsStorage eventsStorage;
  final TemporaryActivitiesStorage temporaryActivitiesStorage;
  final String userId;

  TemporaryActivitiesService(this.eventsStorage, this.temporaryActivitiesStorage, this.userId);

  addActivities(List emotions, {String? reason}) {
    //TODO mirar si nunca he tenido una de tipo principios explicar, si no he tenido ninguna de dieta de perdon explicar
    List<TemporaryActivity> activities = [];
    if (emotions.contains(Emotion.anger.name)) {
      activities.addAll(List.generate(7, (index) {
        return ForgivenessDietActivity(
          id: const Uuid().v4(),
          userId: userId,
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
        userId: userId,
        activityId: ActivityId.prioritisationPrinciplesActivityId,
        dateTime: DateTime.now(),
      ));
    }
    for (var element in activities) {
      temporaryActivitiesStorage.add(element);
    }
  }

  Future<void> saveEvent(Event event) async {
    await eventsStorage.add(event);
  }
}
