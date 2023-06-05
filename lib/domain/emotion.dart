import 'package:flutter/material.dart';
import 'package:inside_out/data/emotions_data.dart';
import 'package:inside_out/domain/question/index.dart';

enum Emotion { sadness, happiness, anger, fear, surprise, disgust }

List<Emotion> getPrimariesEmotions() {
  return [
    Emotion.sadness,
    Emotion.anger,
    Emotion.fear,
    Emotion.happiness,
  ];
}

extension EmotionFromString on String {
  Emotion getEmotion() {
    for (Emotion emotion in getPrimariesEmotions()) {
      if (emotion.name == this) {
        return emotion;
      }
    }
    throw FlutterError("Does not exist a primary emotion that correspond to $this");
  }
}

extension EmotionsResources on Emotion {
  PrimaryEmotion getPrimaryEmotion() {
    switch (this) {
      case Emotion.sadness:
        return PrimaryEmotion.sadness();
      case Emotion.happiness:
        return PrimaryEmotion.happiness();
      case Emotion.anger:
        return PrimaryEmotion.anger();
      case Emotion.fear:
        return PrimaryEmotion.fear();
      case Emotion.surprise:
        return PrimaryEmotion.surprise();
      case Emotion.disgust:
        return PrimaryEmotion.disgust();
    }
  }

  Color getColor() {
    switch (this) {
      case Emotion.sadness:
        return const Color(0xff467ff9);
      case Emotion.happiness:
        return const Color(0xffff9d32);
      case Emotion.anger:
        return const Color(0xffb41e1a);
      case Emotion.fear:
        return const Color(0xff9241cc);
      case Emotion.surprise:
        return const Color(0xff8c3205);
      case Emotion.disgust:
        return const Color(0xff7c9000);
    }
  }

  List<String> getBehaviours() {
    List<String> result = [];
    if (this == Emotion.disgust) {
      result.addAll(behaviours[Emotion.anger] ?? []);
      result.addAll(behaviours[Emotion.sadness] ?? []);
    } else if (this == Emotion.surprise) {
      result.addAll(behaviours[Emotion.happiness] ?? []);
      result.addAll(behaviours[Emotion.fear] ?? []);
    } else {
      result.addAll(behaviours[this] ?? []);
    }

    return result.toSet().toList();
  }

  List<String> getBodySensations() {
    List<String> result = [];
    if (this == Emotion.disgust) {
      result.addAll(bodySensations[Emotion.anger] ?? []);
      result.addAll(bodySensations[Emotion.sadness] ?? []);
    } else if (this == Emotion.surprise) {
      result.addAll(bodySensations[Emotion.happiness] ?? []);
      result.addAll(bodySensations[Emotion.fear] ?? []);
    } else {
      result.addAll(bodySensations[this] ?? []);
    }
    return result.toSet().toList();
  }
}

class PrimaryEmotion {
  final Emotion emotion;
  final List<SecondaryEmotion> secondaryEmotions;

  PrimaryEmotion._(this.emotion, this.secondaryEmotions);

  factory PrimaryEmotion.sadness() => PrimaryEmotion._(
        Emotion.sadness,
        _getSecondaryEmotionsFromEmotion(Emotion.sadness),
      );

  factory PrimaryEmotion.happiness() => PrimaryEmotion._(
        Emotion.happiness,
        _getSecondaryEmotionsFromEmotion(Emotion.happiness),
      );

  factory PrimaryEmotion.anger() => PrimaryEmotion._(
        Emotion.anger,
        _getSecondaryEmotionsFromEmotion(Emotion.anger),
      );

  factory PrimaryEmotion.fear() => PrimaryEmotion._(
        Emotion.fear,
        _getSecondaryEmotionsFromEmotion(Emotion.fear),
      );

  factory PrimaryEmotion.surprise() => PrimaryEmotion._(
        Emotion.surprise,
        _getSecondaryEmotionsFromEmotion(Emotion.surprise),
      );

  factory PrimaryEmotion.disgust() => PrimaryEmotion._(
        Emotion.disgust,
        _getSecondaryEmotionsFromEmotion(Emotion.disgust),
      );

  List<TertiaryEmotion> _getTertiaryEmotions() {
    List<TertiaryEmotion> tertiaryEmotions = [];
    for (var secondaryEmotion in secondaryEmotions) {
      tertiaryEmotions.addAll(secondaryEmotion.tertiaryEmotions);
    }
    return tertiaryEmotions;
  }

  List<ValueCheckBox> getCheckBoxTertiaryEmotionsValues() {
    List<String> saveValue = [];
    if (emotion == Emotion.disgust) {
      saveValue.add(Emotion.anger.name);
      saveValue.add(Emotion.sadness.name);
    } else if (emotion == Emotion.surprise) {
      saveValue.add(Emotion.fear.name);
      saveValue.add(Emotion.happiness.name);
    } else {
      saveValue.add(emotion.name);
    }
    List<ValueCheckBox> values = [];
    _getTertiaryEmotions().forEach((tertiaryEmotion) {
      values.add(ValueCheckBox(
        tertiaryEmotion.tertiaryEmotionKey,
        hint: tertiaryEmotion.descriptionKey,
        saveValues: saveValue,
      ));
    });
    return values;
  }

  List<String> getTertiaryEmotions() {
    List<String> values = [];
    _getTertiaryEmotions().forEach((tertiaryEmotion) {
      values.add(tertiaryEmotion.tertiaryEmotionKey);
    });
    return values;
  }
}

class SecondaryEmotion {
  final Emotion emotion;
  final String secondaryEmotionKey;
  final List<TertiaryEmotion> tertiaryEmotions;
  late String? descriptionKey;

  SecondaryEmotion({
    required this.emotion,
    required this.secondaryEmotionKey,
    required this.tertiaryEmotions,
  }) {
    descriptionKey = null;
    // descriptionKey = '${secondaryEmotionKey}_description';
  }
}

class TertiaryEmotion {
  final Emotion emotion;
  final String secondaryEmotionKey;
  final String tertiaryEmotionKey;
  late String? descriptionKey;

  TertiaryEmotion({
    required this.emotion,
    required this.secondaryEmotionKey,
    required this.tertiaryEmotionKey,
  }) {
    descriptionKey = null;
    // descriptionKey = '${tertiaryEmotionKey}_description';
  }
}

List<SecondaryEmotion> _getSecondaryEmotionsFromEmotion(Emotion emotion) {
  return secondaryEmotionsMap[emotion]!
      .map(
        (secondaryEmotion) => SecondaryEmotion(
          emotion: emotion,
          secondaryEmotionKey: secondaryEmotion,
          tertiaryEmotions: tertiaryEmotionsMaps[emotion]![secondaryEmotion]!
              .map(
                (tertiaryEmotion) => TertiaryEmotion(
                  emotion: emotion,
                  secondaryEmotionKey: secondaryEmotion,
                  tertiaryEmotionKey: tertiaryEmotion,
                ),
              )
              .toList(),
        ),
      )
      .toList();
}
