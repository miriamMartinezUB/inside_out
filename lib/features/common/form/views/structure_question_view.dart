import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/index.dart';
import 'package:inside_out/features/common/form/views/carrousel_question_view.dart';
import 'package:inside_out/features/common/form/views/checkbox_question_view.dart';
import 'package:inside_out/features/common/form/views/free_text_question_view.dart';
import 'package:inside_out/features/common/form/views/single_select_question_view.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class StructureQuestionView extends StatelessWidget {
  final Question question;
  final Function(dynamic value) onChange;

  const StructureQuestionView({
    super.key,
    required this.question,
    required this.onChange,
  });

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
        if (question.imagePath != null) ...[
          const SizedBox(height: Dimens.paddingXLarge),
          Center(
            child: ImageView(
              question.imagePath!,
              height: Dimens.iconXXXLarge,
            ),
          )
        ],
        const SizedBox(height: Dimens.paddingLarge),
        if (question is FreeTextQuestion)
          FreeTextQuestionView(
            initialText: (question as FreeTextQuestion).value,
            hint: (question as FreeTextQuestion).hint,
            isLong: (question as FreeTextQuestion).longText,
            isObscureText: (question as FreeTextQuestion).isObscureText,
            minLines: (question as FreeTextQuestion).minLines,
            maxLength: (question as FreeTextQuestion).maxLength,
            onChanged: onChange,
          ),
        if (question is SingleSelectionQuestion)
          SingleSelectQuestionView(
            values: (question as SingleSelectionQuestion).values,
            initialValue: (question as SingleSelectionQuestion).selectedValue,
            onChange: onChange,
          ),
        if (question is CheckBoxQuestion)
          CheckBoxQuestionView(
            values: (question as CheckBoxQuestion).values!,
            valuesSelected: (question as CheckBoxQuestion).selectedValues ?? [],
            onChange: onChange,
          ),
        if (question is CarrouselQuestion)
          CarrouselQuestionView(
            items: (question as CarrouselQuestion).items,
            onChange: onChange,
          ),
      ],
    );
  }
}
