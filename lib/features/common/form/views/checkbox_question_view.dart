import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class CheckBoxQuestionView extends StatelessWidget {
  final List<String> values;
  final List valuesSelected;
  final Function(String newValue) onChange;

  const CheckBoxQuestionView({
    Key? key,
    required this.values,
    required this.valuesSelected,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: values.length,
      itemBuilder: (context, index) {
        String value = values[index];
        return Row(
          children: [
            Checkbox(
              fillColor: MaterialStateProperty.all(Provider.of<ThemeService>(context).paletteColors.primary),
              value: valuesSelected.contains(value),
              onChanged: (bool? selected) {
                onChange(value);
              },
            ),
            Expanded(
              child: AppText(
                translate(value),
                type: TextTypes.smallBody,
              ),
            ),
          ],
        );
      },
    );
  }
}
