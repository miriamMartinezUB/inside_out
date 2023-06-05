import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class ListSectionView extends StatelessWidget {
  final String? title;
  final List items;
  final Axis axis;

  const ListSectionView({
    Key? key,
    required this.title,
    required this.items,
    this.axis = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          AppText(
            translate(title!),
            color: paletteColors.textButton,
            type: TextTypes.smallBodyMedium,
          ),
          const SizedBox(height: Dimens.paddingMedium),
        ],
        SizedBox(
          height: axis == Axis.horizontal ? 42 : null,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: axis,
            primary: false,
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: axis == Axis.horizontal
                      ? 0
                      : index == items.length - 1
                          ? 0
                          : Dimens.paddingMedium,
                  right: axis == Axis.vertical
                      ? 0
                      : index == items.length - 1
                          ? 0
                          : Dimens.paddingMedium,
                ),
                child: ListItemView(text: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ListItemView extends StatelessWidget {
  final String text;
  final bool shouldTranslate;

  const ListItemView({
    super.key,
    required this.text,
    this.shouldTranslate = true,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;

    return Container(
      padding: const EdgeInsets.all(Dimens.paddingMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimens.radiusXLarge),
        color: paletteColors.card,
      ),
      child: Container(
        margin: const EdgeInsets.all(Dimens.paddingSmall),
        child: AppText(
          shouldTranslate ? translate(text) : text,
          color: themeService.themePreference == ThemePreference.light ? paletteColors.active : paletteColors.text,
          type: TextTypes.tinyBody,
        ),
      ),
    );
  }
}
