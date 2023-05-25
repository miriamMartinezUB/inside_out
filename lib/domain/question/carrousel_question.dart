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
        title: title,
        items: items ?? this.items,
        mandatory: mandatory,
      );
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
