import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/content/information_content.dart';
import 'package:inside_out/resources/activity_id.dart';

class InformationDataFiller {
  final Database database;

  InformationDataFiller(this.database);

  fillDatabaseWithData() {
    InformationContent emotions = InformationContent(
      title: 'emotion_content_title',
      description: 'emotion_content_description',
      cards: [
        InformationCardContent(
          title: 'what_are_emotions_title',
          isPrimary: true,
          activityId: ActivityId.whatAreEmotionsActivityId,
        ),
        InformationCardContent(
          title: 'primary_emotions_title',
          isPrimary: true,
          activityId: ActivityId.primaryEmotionsActivityId,
        ),
        InformationCardContent(
          title: 'anger',
          activityId: ActivityId.angerActivityId,
        ),
        InformationCardContent(
          title: 'sadness',
          activityId: ActivityId.sadnessActivityId,
        ),
        InformationCardContent(
          title: 'fear',
          activityId: ActivityId.fearActivityId,
        ),
        InformationCardContent(
          title: 'happiness',
          activityId: ActivityId.happinessActivityId,
        ),
      ],
    );

    database.addInformation(emotions);
  }
}
