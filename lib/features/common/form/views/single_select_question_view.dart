import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class SingleSelectQuestionView extends StatelessWidget {
  final List<String> values;
  final String? initialValue;
  final Function(String value) onChange;

  const SingleSelectQuestionView({
    Key? key,
    required this.values,
    required this.initialValue,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int group = initialValue == null ? 0 : values.indexOf(initialValue!);
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: values.length,
      itemBuilder: (context, index) {
        String value = values[index];
        return Row(
          children: [
            Radio(
              fillColor: MaterialStateProperty.all(Provider.of<ThemeService>(context).paletteColors.primary),
              value: index,
              groupValue: group,
              onChanged: (index) {
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
