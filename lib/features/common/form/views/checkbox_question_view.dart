import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/question/check_box_question.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class CheckBoxQuestionView extends StatelessWidget {
  final List<ValueCheckBox> values;
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
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    return GridView.count(
      primary: false,
      mainAxisSpacing: Dimens.paddingLarge,
      childAspectRatio: 3,
      shrinkWrap: true,
      crossAxisCount: kIsWeb ? 5 : 2,
      children: List.generate(
        values.length,
        (index) {
          String value = values[index].value;
          return Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: Dimens.paddingBase),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.radiusXLarge),
                  color: paletteColors.card,
                  boxShadow: [
                    BoxShadow(
                      color: paletteColors.shadow,
                      blurRadius: 2.5,
                      spreadRadius: 0.5,
                      offset: const Offset(2, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      fillColor: MaterialStateProperty.all(paletteColors.primary),
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
                ),
              ),
              if (values[index].hint != null)
                Badge(
                  isLabelVisible: false,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.info_outline_rounded,
                      size: Dimens.iconBase,
                      color: paletteColors.primary,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
