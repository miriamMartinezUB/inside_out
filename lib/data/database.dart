import 'package:flutter/widgets.dart';
import 'package:inside_out/data/activities_data_filler.dart';
import 'package:inside_out/data/forms_data_filler.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/form.dart';

class Database {
  final Map<String, AppForm> _forms = {};
  final Map<String, Activity> _activities = {};

  Database() {
    FormsDataFiller(this).fillDatabaseWithData();
    ActivitiesDataFiller(this).fillDatabaseWithData();
  }

  void addForm(AppForm appForm) {
    _forms[appForm.id] = appForm;
  }

  AppForm getFormById(String formId) {
    if (_forms.containsKey(formId)) {
      return _forms[formId]!;
    }
    throw FlutterError('Not form for id: $formId');
  }

  void addActivity(Activity activity) {
    _activities[activity.id] = activity;
  }

  Activity getActivityById(String activityId) {
    if (_activities.containsKey(activityId)) {
      return _activities[activityId]!;
    }
    throw FlutterError('Not activity for id: $activityId');
  }
}
