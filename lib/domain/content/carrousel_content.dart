import 'package:flutter/material.dart';
import 'package:inside_out/domain/content/simple_text.dart';
import 'package:uuid/uuid.dart';

class CarrouselContent {
  final String id;
  final String title;
  final String description;
  final List<CarrouselContentItem> items;
  final double? height;

  CarrouselContent({
    required this.title,
    required this.description,
    required this.items,
    this.height = 400,
  }) : id = const Uuid().v4();

  CarrouselContent copyWith(List<CarrouselContentItem>? items) {
    return CarrouselContent(
      title: title,
      description: description,
      items: items ?? this.items,
      height: height,
    );
  }
}

class CarrouselContentItem {
  final String id;
  final String title;
  final Color? color;
  final String? imagePath;
  final List<SimpleText>? sections;

  CarrouselContentItem({
    required this.title,
    this.sections,
    this.color,
    this.imagePath,
  }) : id = const Uuid().v4();

  CarrouselContentItem copyWith({List<SimpleText>? sections}) {
    return CarrouselContentItem(
      title: title,
      color: color,
      imagePath: imagePath,
      sections: sections ?? this.sections,
    );
  }
}
