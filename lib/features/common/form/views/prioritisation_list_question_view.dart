import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class PrioritisationListView extends StatelessWidget {
  final List<String> values;
  final Function(List<String> newValuesOrder) onChange;
  const PrioritisationListView({
    Key? key,
    required this.values,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingXXLarge),
      child: CustomScrollView(
        primary: false,
        shrinkWrap: true,
        slivers: [
          SliverReorderableList(
            itemCount: values.length,
            itemBuilder: (context, index) {
              return ReorderableDragStartListener(
                index: index,
                key: Key('$index'),
                child: Card(
                  color: paletteColors.card,
                  child: ListTile(
                    title: AppText(values[index]),
                    leading: Icon(
                      Icons.sort_rounded,
                      color: paletteColors.text,
                    ),
                  ),
                ),
              );
            },
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final String item = values.removeAt(oldIndex);
              values.insert(newIndex, item);
              onChange(values);
            },
          ),
        ],
      ),
    );
  }
}
