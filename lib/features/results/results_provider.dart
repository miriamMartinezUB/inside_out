import 'package:flutter/cupertino.dart';
import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/content/carrousel_content.dart';
import 'package:inside_out/domain/content/simple_text.dart';
import 'package:inside_out/domain/objectives.dart';
import 'package:inside_out/domain/user_emotion.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/storage/remote/objectives_storage.dart';
import 'package:inside_out/infrastructure/storage/remote/user_emotion_storage.dart';

class ResultsProvider extends ChangeNotifier {
  final FirebaseService firebaseService;
  final LocaleStorageService localeStorageService;
  late final Database _database;
  late final UserEmotionStorage _userEmotionStorage;
  late final ObjectivesStorage _objectivesStorage;
  late CarrouselContent emotionsGrid;
  late CarrouselContent? objectivesGrid;
  late CarrouselContent? principlesAndValues;
  bool loading = true;

  ResultsProvider({
    required this.firebaseService,
    required this.localeStorageService,
  }) {
    _database = Database();
    _userEmotionStorage =
        UserEmotionStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _objectivesStorage =
        ObjectivesStorage(firebaseService: firebaseService, localeStorageService: localeStorageService);
    _loadContent();
  }

  Future<void> _loadContent() async {
    emotionsGrid = await _emotionsGrid;
    objectivesGrid = await _objectivesGrid;
    loading = false;
    notifyListeners();
  }

  Future<CarrouselContent> get _emotionsGrid async {
    CarrouselContent emotionGridStatic = _database.emotionsGridStatic;
    List<CarrouselContentItem> items = [];
    for (CarrouselContentItem item in emotionGridStatic.items) {
      UserEmotion? userEmotion = await _userEmotionStorage.getByEmotion(item.title);
      List<SimpleText> sections = [];
      for (SimpleText section in item.sections ?? []) {
        if (section.title == 'body_sensations') {
          if (userEmotion != null && userEmotion.bodySensations.isNotEmpty) {
            sections.add(
              section.copyWith(
                bulletPoints: userEmotion.bodySensations.map((e) => BulletPoint(e)).toList(),
              ),
            );
          }
        } else if (section.title == 'behaviours') {
          if (userEmotion != null && userEmotion.behaviours.isNotEmpty) {
            sections.add(
              section.copyWith(
                bulletPoints: userEmotion.behaviours.map((e) => BulletPoint(e)).toList(),
              ),
            );
          }
        } else {
          sections.add(section);
        }
      }
      items.add(item.copyWith(sections: sections));
    }
    return emotionGridStatic.copyWith(items);
  }

  Future<CarrouselContent?> get _objectivesGrid async {
    CarrouselContent objectivesGridStatic = _database.objectivesGridStatic;
    List<Objectives> listObjectives = (await _objectivesStorage.all);
    if (listObjectives.isEmpty) return null;
    Objectives objectives = listObjectives.first;
    if (objectives.thingsToChange == null ||
        objectives.thingsToChange!.isEmpty && objectives.thingsToLearn == null ||
        objectives.thingsToLearn!.isEmpty && objectives.thingsToKeep == null ||
        objectives.thingsToKeep!.isEmpty && objectives.thingsToPrevent == null ||
        objectives.thingsToPrevent!.isEmpty) return null;
    List<CarrouselContentItem> items = [];
    for (CarrouselContentItem item in objectivesGridStatic.items) {
      late List list;
      if (item.title == 'objectives_grid_keep_title') {
        list = objectives.thingsToKeep ?? [];
      } else if (item.title == 'objectives_grid_learn_title') {
        list = objectives.thingsToLearn ?? [];
      } else if (item.title == 'objectives_grid_change_title') {
        list = objectives.thingsToChange ?? [];
      } else if (item.title == 'objectives_grid_prevent_title') {
        list = objectives.thingsToPrevent ?? [];
      }
      if (list.isNotEmpty) {
        items.add(
          item.copyWith(
            sections: list.map((e) => SimpleText(text: e)).toList(),
          ),
        );
      }
    }
    return objectivesGridStatic.copyWith(items);
  }
}
