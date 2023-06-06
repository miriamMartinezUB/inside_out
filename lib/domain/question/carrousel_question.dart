import 'package:flutter/material.dart';
import 'package:inside_out/domain/question/check_box_question.dart';
import 'package:inside_out/domain/question/question.dart';

class CarrouselQuestion extends Question {
  final List<CarrouselQuestionItem> items;

  CarrouselQuestion({
    required String id,
    required String title,
    required this.items,
    bool mandatory = true,
  }) : super(
          id: id,
          title: title,
          mandatory: mandatory,
        );

  CarrouselQuestion copyWith({
    List<CarrouselQuestionItem>? items,
  }) =>
      CarrouselQuestion(
        id: id,
        title: title!,
        items: items ?? this.items,
        mandatory: mandatory,
      );

  @override
  bool get isValid {
    List selectedItems = [];
    for (var element in items) {
      selectedItems.addAll(element.selectedValues ?? []);
    }
    return (mandatory && selectedItems.isNotEmpty) || !mandatory;
  }

  @override
  get answer {
    List selectedItems = [];
    for (var element in items) {
      selectedItems.addAll(element.selectedValues ?? []);
    }
    return selectedItems.isEmpty ? null : selectedItems.toSet().toList();
  }

  @override
  get answerValue {
    List selectedItems = [];
    for (var element in items) {
      selectedItems.addAll(element.selectedSaveValue);
    }
    return selectedItems.isEmpty ? null : selectedItems.toSet().toList();
  }
}

class CarrouselQuestionItem {
  final String id;
  final String title;
  final Color color;
  final String imagePath;
  final List<ValueCheckBox> values;
  final List? selectedValues;

  CarrouselQuestionItem({
    required this.id,
    required this.title,
    required this.color,
    required this.imagePath,
    required this.values,
    this.selectedValues,
  });

  List get selectedSaveValue {
    List selectedSaveValue = [];
    for (var value in selectedValues ?? []) {
      ValueCheckBox valueCheckBox = values.firstWhere((element) => element.value == value);
      if (valueCheckBox.saveValues != null) {
        selectedSaveValue.addAll(valueCheckBox.saveValues!);
      } else {
        selectedSaveValue.add(value);
      }
    }
    return selectedSaveValue.toSet().toList();
  }

  CarrouselQuestionItem copyWith({
    List? selectedValues,
    List<ValueCheckBox>? values,
  }) =>
      CarrouselQuestionItem(
        id: id,
        title: title,
        color: color,
        imagePath: imagePath,
        values: values ?? this.values,
        selectedValues: selectedValues ?? this.selectedValues,
      );
}
