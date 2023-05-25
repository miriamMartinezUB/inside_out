import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:uuid/uuid.dart';

class ActivitiesDataFiller {
  final Database database;

  ActivitiesDataFiller(this.database);

  fillDatabaseWithData() {
    /// Forms activities

    AppForm thoughtDiaryFormStep1 = AppForm(
      id: ActivityStepId.thoughtDiaryActivityStep1Id,
      name: 'thought_diary_form_step1_title',
      actionText: 'next',
      questions: [
        CarrouselQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep1QuestionId,
          title: 'thought_diary_form_step1_question',
          items: Emotion.values
              .map(
                (emotion) => CarrouselQuestionItem(
                  id: const Uuid().v4(),
                  title: emotion.name,
                  color: emotion.getColor(),
                  imagePath: '${emotion.name}.png',
                  values: emotion.getPrimaryEmotion().getCheckBoxTertiaryEmotionsValues(),
                ),
              )
              .toList(),
        ),
      ],
    );

    AppForm thoughtDiaryFormStep2 = AppForm(
      id: ActivityStepId.thoughtDiaryActivityStep2Id,
      name: 'thought_diary_form_step2_title',
      actionText: 'next',
      questions: [
        CheckBoxQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep2QuestionId,
          title: 'thought_diary_form_step2_question',
        ),
      ],
    );

    AppForm thoughtDiaryFormStep3 = AppForm(
      id: ActivityStepId.thoughtDiaryActivityStep3Id,
      name: 'thought_diary_form_step3_title',
      actionText: 'next',
      questions: [
        CheckBoxQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep3QuestionId,
          title: 'thought_diary_form_step3_question',
        ),
      ],
    );

    AppForm thoughtDiaryFormStep4 = AppForm(
      id: ActivityStepId.thoughtDiaryActivityStep4Id,
      name: 'thought_diary_form_step4_title',
      actionText: 'next',
      questions: [
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep4QuestionId,
          title: 'thought_diary_form_step4_question',
          longText: true,
          hint: 'write_here',
        ),
      ],
    );

    AppForm thoughtDiaryFormStep5 = AppForm(
      id: ActivityStepId.thoughtDiaryActivityStep5Id,
      name: 'thought_diary_form_step5_title',
      actionText: 'next',
      questions: [
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep5QuestionId,
          title: 'thought_diary_form_step5_question',
          longText: true,
          mandatory: false,
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep5Question2Id,
          title: 'thought_diary_form_step5_question2',
          longText: true,
          mandatory: false,
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep5Question3Id,
          title: 'thought_diary_form_step5_question3',
          longText: true,
          mandatory: false,
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep5Question4Id,
          title: 'thought_diary_form_step5_question4',
          longText: true,
          mandatory: false,
        ),
      ],
    );

    AppForm thoughtDiaryFormStep6 = AppForm(
      id: ActivityStepId.thoughtDiaryActivityStep6Id,
      name: 'thought_diary_form_step6_title',
      actionText: 'finish',
      questions: [
        Question(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep6QuestionId,
          title: 'thought_diary_form_step6_question',
          imagePath: 'descubre_mas.png',
          mandatory: false,
        ),
      ],
    );

    ///Adding activities

    Activity thoughtDiaryActivity = Activity(
      id: ActivityId.thoughtDiaryActivityId,
      name: 'thought_diary_activity_title',
      steps: [
        ActivityStep(form: thoughtDiaryFormStep1),
        ActivityStep(form: thoughtDiaryFormStep2),
        ActivityStep(form: thoughtDiaryFormStep3),
        ActivityStep(form: thoughtDiaryFormStep4),
        ActivityStep(form: thoughtDiaryFormStep5),
        ActivityStep(form: thoughtDiaryFormStep6),
      ],
    );

    database.addActivity(thoughtDiaryActivity);
  }
}
