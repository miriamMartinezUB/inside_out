import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

Radius _radius = const Radius.circular(Dimens.radiusLarge);

class CardInformation extends StatelessWidget {
  final String title;
  final int timesCompleted;
  final Function()? onTap;
  final bool isPrimary;

  const CardInformation({
    Key? key,
    required this.title,
    this.isPrimary = false,
    this.timesCompleted = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    final String image = isPrimary
        ? 'assets/images/info_background_card.png'
        : themeService.themePreference == ThemePreference.light
            ? 'assets/images/info_background_card_secondary.png'
            : 'assets/images/info_background_card_secondary_dark.png';
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.only(top: Dimens.paddingMedium),
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.paddingLarge,
              vertical: Dimens.paddingXLarge,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(_radius),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: paletteColors.shadow,
                  blurRadius: 2.5,
                  spreadRadius: 0.5,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: AppText(
                translate(title),
                color: isPrimary ? paletteColors.textButton : paletteColors.text,
                type: isPrimary ? TextTypes.body : TextTypes.smallBodyMedium,
              ),
            ),
          ),
          if (timesCompleted > 0)
            Badge(
              isLabelVisible: false,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimens.radiusLarge),
                  border: Border.all(
                    color: paletteColors.active,
                    width: Dimens.borderThickness,
                  ),
                  color: paletteColors.background,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.paddingSmall),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(
                        timesCompleted.toString(),
                        color: paletteColors.active,
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        color: paletteColors.active,
                        size: Dimens.iconBase,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
