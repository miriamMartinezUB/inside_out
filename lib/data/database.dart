import 'package:flutter/widgets.dart';
import 'package:inside_out/data/activities_data_filler.dart';
import 'package:inside_out/data/forms_data_filler.dart';
import 'package:inside_out/data/information_data_filler.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/domain/content/carrousel_content.dart';
import 'package:inside_out/domain/content/information_content.dart';
import 'package:inside_out/domain/content/simple_text.dart';
import 'package:inside_out/domain/emotion.dart';
import 'package:inside_out/domain/form.dart';

class Database {
  final Map<String, AppForm> _forms = {};
  final Map<String, Activity> _activities = {};
  final List<InformationContent> content = [];

  Database() {
    FormsDataFiller(this).fillDatabaseWithData();
    ActivitiesDataFiller(this).fillDatabaseWithData();
    InformationDataFiller(this).fillDatabaseWithData();
  }

  void addInformation(InformationContent informationContent) {
    content.add(informationContent);
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

  CarrouselContent get emotionsGridStatic => CarrouselContent(
        title: 'emotional_grid_title',
        description: 'emotional_grid_description',
        items: getPrimariesEmotions()
            .map(
              (emotion) => CarrouselContentItem(
                title: emotion.name,
                color: emotion.getColor(),
                imagePath: '${emotion.name}.png',
                sections: [
                  SimpleText(
                    title: 'body_sensations',
                  ),
                  SimpleText(
                    title: 'behaviours',
                  ),
                  SimpleText(
                    text: 'tense_${emotion.name}_body',
                    title: 'tense_title',
                  ),
                  SimpleText(
                    text: 'functionality_${emotion.name}_body',
                    title: 'functionality_title',
                  ),
                ],
              ),
            )
            .toList(),
      );

  CarrouselContent get objectivesGridStatic => CarrouselContent(
        title: 'objectives_grid_title',
        description: 'objectives_grid_description',
        height: 200,
        items: [
          CarrouselContentItem(
            title: 'objectives_grid_keep_title',
          ),
          CarrouselContentItem(
            title: 'objectives_grid_learn_title',
          ),
          CarrouselContentItem(
            title: 'objectives_grid_change_title',
          ),
          CarrouselContentItem(
            title: 'objectives_grid_prevent_title',
          ),
        ],
      );
}
