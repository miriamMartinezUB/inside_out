import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/features/form/views/question_checkbox..dart';
import 'package:inside_out/features/form/views/question_free_text.dart';
import 'package:inside_out/features/form/views/question_single_select.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class QuestionStructure extends StatelessWidget {
  final Question question;
  final Function(String value) onChange;

  const QuestionStructure({super.key, required this.question, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return Column(
      key: Key(question.id),
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Flexible(child: AppText(translate(question.title))),
            if (question.mandatory) ...[
              const SizedBox(width: Dimens.paddingLarge),
              AppText(
                '*',
                color: paletteColors.textError,
              ),
            ],
          ],
        ),
        if (question.subtitle != null) ...[
          const SizedBox(width: Dimens.paddingLarge),
          AppText(
            translate(question.subtitle!),
            color: paletteColors.textSubtitle,
          ),
        ],
        const SizedBox(height: Dimens.paddingLarge),
        if (question is FreeTextQuestion)
          QuestionFreeText(
            initialText: (question as FreeTextQuestion).value,
            isLong: (question as FreeTextQuestion).longText,
            onChanged: onChange,
          ),
        if (question is SingleSelectionQuestion)
          QuestionSingleSelect(
            values: (question as SingleSelectionQuestion).values,
            initialValue: (question as SingleSelectionQuestion).selectedValue,
            onChange: onChange,
          ),
        if (question is CheckBoxQuestion)
          QuestionCheckBox(
            values: (question as CheckBoxQuestion).values!,
            valuesSelected: (question as CheckBoxQuestion).selectedValues ?? [],
            onChange: onChange,
          ),
      ],
    );
  }
}
