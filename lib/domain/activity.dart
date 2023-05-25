import 'package:inside_out/domain/form.dart';

class Activity {
  final String id;
  final String name;
  final List<ActivityStep> steps;

  Activity({
    required this.id,
    required this.name,
    required this.steps,
  });

  Activity copyWith(List<ActivityStep> steps) => Activity(
        id: id,
        name: name,
        steps: steps,
      );
}

class ActivityStep {
  final AppForm form;

  ActivityStep({
    required this.form,
  });

  ActivityStep copyWith(AppForm form) => ActivityStep(form: form);
}
