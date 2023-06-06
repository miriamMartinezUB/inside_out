import 'package:flutter/cupertino.dart';
import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/activity_answer.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/resources/activity_id.dart';
import 'package:inside_out/utils/temporary_activities_service.dart';
import 'package:inside_out/utils/thought_diary_activity_service.dart';

class ActivityStepperProvider with ChangeNotifier {
  final String activityId;
  final String? reason;
  late Activity _activity;
  int _currentIndexStep = 0;

  ActivityStepperProvider(this.activityId, {this.reason}) {
    _activity = Database().getActivityById(activityId);
    ActivityStep activityStep = steps[_currentIndexStep];
    if (activityStep.form.id == ActivityStepId.forgivenessDietAddPhrases) {
      setActivity(TemporaryActivitiesService.getModifiedForgivenessDietReason(reason ?? '', activityStep));
    }
  }

  int get currentIndexStep => _currentIndexStep;

  List<ActivityStep> get steps => _activity.steps;

  void setCurrentStep(int step) {
    _currentIndexStep = step;
    ActivityStep activityStep = steps[_currentIndexStep];
    if (activityStep.form.id == ActivityStepId.thoughtDiaryBodySensations ||
        activityStep.form.id == ActivityStepId.thoughtDiaryBehaviours) {
      setActivity(ThoughtDiaryActivityService.getModifiedThoughtDiaryQuestionValues(
          (steps.first.form.questions.first as CarrouselQuestion), activityStep));
    }
    if (activityStep.form.id == ActivityStepId.prioritisationPrinciplesAndValuesOrder) {
      setActivity(
          TemporaryActivitiesService.getModifiedPrinciplesAndValuesQuestionValues(steps.first.form, activityStep));
    }
    if (activityStep.form.id == ActivityStepId.forgivenessDietRepeatForgivenessPhrases) {
      setActivity(TemporaryActivitiesService.getModifiedForgivenessDietPhrases(
          steps.first.form.questions.last.answer, activityStep));
    }
    notifyListeners();
  }

  void setActivity(AppForm form) {
    List<ActivityStep> steps = [];
    for (ActivityStep step in _activity.steps) {
      late ActivityStep newStep;
      if (step == _activity.steps[_currentIndexStep]) {
        newStep = step.copyWith(form);
      } else {
        newStep = step;
      }
      steps.add(newStep);
    }
    _activity = _activity.copyWith(steps: steps);
  }

  ActivityAnswer get activityAnswer {
    List<Answer> answers = [];
    for (ActivityStep step in steps) {
      for (Question question in step.form.questions) {
        answers.add(
          Answer(
            questionId: question.id,
            answer: question.answer,
            answerValue: question.answerValue,
          ),
        );
      }
    }
    final a = ActivityAnswer(
      activityId: activityId,
      answers: answers,
    );
    return a;
  }
}
