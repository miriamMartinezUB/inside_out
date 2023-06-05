import 'package:flutter/cupertino.dart';
import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/activity_answer.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/resources/activity_id.dart';

class ActivityStepperProvider with ChangeNotifier {
  final String activityId;
  late Activity _activity;
  int _currentIndexStep = 0;

  ActivityStepperProvider(this.activityId) {
    _activity = Database().getActivityById(activityId);
  }

  int get currentIndexStep => _currentIndexStep;

  List<ActivityStep> get steps => _activity.steps;

  void setCurrentStep(int step) {
    _currentIndexStep = step;
    ActivityStep activityStep = steps[_currentIndexStep];
    if (activityStep.form.id == ActivityStepId.thoughtDiaryBodySensations ||
        activityStep.form.id == ActivityStepId.thoughtDiaryBehaviours) {
      List selectedValues = [];
      for (var item in (steps.first.form.questions.first as CarrouselQuestion).items) {
        selectedValues.addAll(item.selectedValues ?? []);
      }
      List<Emotion> selectedEmotions = _getEmotionsFromSelectedValues(selectedValues);
      List<String> values = [];
      if (activityStep.form.id == ActivityStepId.thoughtDiaryBodySensations) {
        for (var emotion in selectedEmotions) {
          values.addAll(
            emotion.getBodySensations().map(
                  (e) => e,
                ),
          );
        }
      }
      if (activityStep.form.id == ActivityStepId.thoughtDiaryBehaviours) {
        for (var emotion in selectedEmotions) {
          values.addAll(
            emotion.getBehaviours().map(
                  (e) => e,
                ),
          );
        }
      }
      AppForm form = activityStep.form.copyWith(
        questions: [
          (activityStep.form.questions.first as CheckBoxQuestion).copyWith(
            values: values.toSet().map((e) => ValueCheckBox(e)).toList(),
          )
        ],
      );
      setActivity(form);
    }
    notifyListeners();
  }

  List<Emotion> _getEmotionsFromSelectedValues(List selectedValues) {
    List<Emotion> emotions = [];
    for (Emotion emotion in Emotion.values) {
      bool contains =
          emotion.getPrimaryEmotion().getTertiaryEmotions().toSet().intersection(selectedValues.toSet()).isNotEmpty;
      if (contains) {
        emotions.add(emotion);
      }
    }
    return emotions;
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

  void onFinish(AppForm form) {}

  ActivityAnswer get activityAnswer {
    List<Answer> answers = [];
    for (ActivityStep step in steps) {
      for (Question question in step.form.questions) {
        answers.add(
          Answer(questionId: question.id, answer: question.answer),
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
