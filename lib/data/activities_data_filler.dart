import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/content/simple_text.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:inside_out/resources/principles_and_values.dart';
import 'package:uuid/uuid.dart';

class ActivitiesDataFiller {
  final Database database;

  ActivitiesDataFiller(this.database);

  fillDatabaseWithData() {
    /// Thought Diary Activity

    AppForm thoughtDiaryFormStep1 = AppForm(
      id: ActivityStepId.thoughtDiaryEmotions,
      name: 'thought_diary_form_step1_title',
      actionText: 'next',
      questions: [
        CarrouselQuestion(
          id: ActivityStepQuestionId.thoughtDiaryEmotionsQuestionId,
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
      id: ActivityStepId.thoughtDiaryBodySensations,
      name: 'thought_diary_form_step2_title',
      actionText: 'next',
      questions: [
        CheckBoxQuestion(
          id: ActivityStepQuestionId.thoughtDiaryBodySensationsQuestionId,
          title: 'thought_diary_form_step2_question',
        ),
      ],
    );

    AppForm thoughtDiaryFormStep3 = AppForm(
      id: ActivityStepId.thoughtDiaryBehaviours,
      name: 'thought_diary_form_step3_title',
      actionText: 'next',
      questions: [
        CheckBoxQuestion(
          id: ActivityStepQuestionId.thoughtDiaryBehavioursQuestionId,
          title: 'thought_diary_form_step3_question',
        ),
      ],
    );

    AppForm thoughtDiaryFormStep4 = AppForm(
      id: ActivityStepId.thoughtDiaryReason,
      name: 'thought_diary_form_step4_title',
      actionText: 'next',
      questions: [
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryReasonQuestionId,
          title: 'thought_diary_form_step4_question',
          longText: true,
          hint: 'write_here',
        ),
      ],
    );

    AppForm thoughtDiaryFormStep5 = AppForm(
      id: ActivityStepId.thoughtDiaryObjectives,
      name: 'thought_diary_form_step5_title',
      actionText: 'next',
      questions: [
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryObjectivesChange,
          title: 'thought_diary_form_step5_question',
          longText: true,
          mandatory: false,
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryObjectivesMaintain,
          title: 'thought_diary_form_step5_question2',
          longText: true,
          mandatory: false,
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryObjectivesLearn,
          title: 'thought_diary_form_step5_question3',
          longText: true,
          mandatory: false,
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.thoughtDiaryObjectivesPrevent,
          title: 'thought_diary_form_step5_question4',
          longText: true,
          mandatory: false,
        ),
      ],
    );

    AppForm thoughtDiaryFormStep6 = AppForm(
      id: ActivityStepId.thoughtDiaryFinish,
      name: 'finish_form_title',
      actionText: 'finish',
      questions: [
        InformationQuestion(
          id: ActivityStepQuestionId.thoughtDiaryActivityStep6QuestionId,
          title: 'thought_diary_form_step6_question',
          imagePath: 'activity_completed.png',
          mandatory: false,
        ),
      ],
    );

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

    /// Explain Emotions
    Activity whatAreEmotionsActivity = Activity(
      id: ActivityId.whatAreEmotionsActivityId,
      name: 'what_are_emotions_title',
      steps: [
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'finish',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                imagePath: 'emotion_description.png',
                content: [
                  SimpleText(text: 'what_are_emotions_text'),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    Activity primaryEmotionsActivity = Activity(
      id: ActivityId.primaryEmotionsActivityId,
      name: 'primary_emotions_title',
      steps: [
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'next',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                content: [
                  SimpleText(text: 'primary_emotions_text'),
                ],
              ),
            ],
          ),
        ),
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'finish',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                imagePath: 'rueda_emociones_es.png',
                content: [
                  SimpleText(text: 'primary_emotions_text2'),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    Activity angerActivity = Activity(
      id: ActivityId.angerActivityId,
      name: 'anger_title',
      steps: [
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'finish',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                content: [
                  SimpleText(text: 'anger_text'),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    Activity sadnessActivity = Activity(
      id: ActivityId.sadnessActivityId,
      name: 'sadness_title',
      steps: [
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'finish',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                content: [
                  SimpleText(text: 'sadness_text'),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    Activity fearActivity = Activity(
      id: ActivityId.fearActivityId,
      name: 'fear_title',
      steps: [
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'finish',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                content: [
                  SimpleText(text: 'fear_text'),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    Activity happinessActivity = Activity(
      id: ActivityId.happinessActivityId,
      name: 'happiness_title',
      steps: [
        ActivityStep(
          form: AppForm(
            id: const Uuid().v4(),
            actionText: 'finish',
            questions: [
              InformationQuestion(
                id: const Uuid().v4(),
                content: [
                  SimpleText(text: 'hapiness_text'),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    database.addActivity(whatAreEmotionsActivity);
    database.addActivity(primaryEmotionsActivity);
    database.addActivity(angerActivity);
    database.addActivity(sadnessActivity);
    database.addActivity(fearActivity);
    database.addActivity(happinessActivity);

    ///  Explain Forgiveness Diet Activity
    ///  Forgiveness Diet Activity

    AppForm forgivenessDietFormStep1 = AppForm(
      id: ActivityStepId.forgivenessDietAddPhrases,
      name: 'forgiveness_diet_card_title',
      actionText: 'next',
      questions: [
        FreeTextQuestion(
          id: ActivityStepQuestionId.forgivenessDietActivityAddAngerPhrases,
          title: 'forgiveness_diet_form_step1_question',
          subtitle: 'forgiveness_diet_form_step1_question_subtitle',
          longText: true,
          hint: 'write_here',
        ),
        FreeTextQuestion(
          id: ActivityStepQuestionId.forgivenessDietActivityAddForgivenessPhrases,
          title: 'forgiveness_diet_form_step1_question2',
          subtitle: 'forgiveness_diet_form_step1_question2_subtitle',
          longText: true,
          hint: 'write_here',
        ),
      ],
    );

    AppForm forgivenessDietFormStep2 = AppForm(
      id: ActivityStepId.forgivenessDietRepeatForgivenessPhrases,
      name: 'forgiveness_diet_card_title',
      actionText: 'next',
      questions: [
        InformationQuestion(
          id: ActivityStepQuestionId.forgivenessDietActivityShowForgivenessPhrases,
          title: 'forgiveness_diet_form_step2_question',
          mandatory: false,
        ),
        for (int index = 0; index < 70; index++)
          FreeTextQuestion(
            id: const Uuid().v4(),
            hint: 'write_here',
            canCopyAndPaste: false,
            mandatory: true,
          ),
      ],
    );

    AppForm forgivenessDietFormStep3 = AppForm(
      id: ActivityStepId.forgivenessDietFinish,
      name: 'finish_form_title',
      actionText: 'finish',
      questions: [
        InformationQuestion(
          id: ActivityStepQuestionId.forgivenessDietActivityFinish,
          title: 'finish_form_subtitle',
          imagePath: 'activity_completed.png',
          mandatory: false,
        ),
      ],
    );

    Activity forgivenessDietActivity = Activity(
      id: ActivityId.forgivenessDietActivityId,
      name: 'forgiveness_diet_activity_title',
      steps: [
        ActivityStep(form: forgivenessDietFormStep1),
        ActivityStep(form: forgivenessDietFormStep2),
        ActivityStep(form: forgivenessDietFormStep3),
      ],
    );

    database.addActivity(forgivenessDietActivity);

    ///  Explain Prioritisation Of Principles Activity
    ///  Prioritisation Of Principles Activity

    AppForm prioritisationPrinciplesFormStep1 = AppForm(
      id: ActivityStepId.prioritisationPrinciplesAndValuesSelection,
      name: 'prioritisation_principles_form_step1_title',
      actionText: 'next',
      questions: [
        CheckBoxQuestion(
          title: 'prioritisation_principles_form_step1_question',
          id: ActivityStepQuestionId.prioritisationPrinciplesSelection,
          values: Principles.values.map((e) => ValueCheckBox(e.name)).toList(),
        ),
        CheckBoxQuestion(
          title: 'prioritisation_principles_form_step1_question2',
          id: ActivityStepQuestionId.prioritisationPrinciplesValuesSelection,
          values: Values.values.map((e) => ValueCheckBox(e.name)).toList(),
        ),
      ],
    );

    AppForm prioritisationPrinciplesFormStep2 = AppForm(
      id: ActivityStepId.prioritisationPrinciplesAndValuesOrder,
      name: 'prioritisation_principles_form_step2_title',
      actionText: 'next',
      questions: [
        PrioritisationListQuestion(
            title: 'prioritisation_principles_form_step2_question',
            id: ActivityStepQuestionId.prioritisationPrinciplesOrder,
            values: Principles.values.map((e) => e.name).toList()),
        PrioritisationListQuestion(
            title: 'prioritisation_principles_form_step2_question2',
            id: ActivityStepQuestionId.prioritisationPrinciplesValuesOrder,
            values: Values.values.map((e) => e.name).toList())
      ],
    );

    AppForm prioritisationPrinciplesFormStep3 = AppForm(
      id: ActivityStepId.prioritisationPrinciplesFinish,
      name: 'finish_form_title',
      actionText: 'finish',
      questions: [
        InformationQuestion(
          id: ActivityStepQuestionId.prioritisationPrinciplesActivityStep3QuestionId,
          title: 'finish_form_subtitle',
          imagePath: 'activity_completed.png',
          mandatory: false,
        ),
      ],
    );

    Activity prioritisationPrinciplesActivity = Activity(
      id: ActivityId.prioritisationPrinciplesActivityId,
      name: 'prioritisation_principles_activity_title',
      steps: [
        ActivityStep(form: prioritisationPrinciplesFormStep1),
        ActivityStep(form: prioritisationPrinciplesFormStep2),
        ActivityStep(form: prioritisationPrinciplesFormStep3),
      ],
    );

    database.addActivity(prioritisationPrinciplesActivity);
  }
}
