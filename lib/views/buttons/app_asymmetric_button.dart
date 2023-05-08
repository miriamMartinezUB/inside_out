import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

BorderRadius _borderRadiusAsymmetricButton = const BorderRadius.only(
  topRight: Radius.circular(Dimens.radiusXLarge),
  bottomRight: Radius.circular(Dimens.radiusXLarge),
);

class AppAsymmetricButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final Function()? onTap;

  const AppAsymmetricButton({
    Key? key,
    required this.text,
    this.shouldTranslate = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return InkWell(
      onTap: onTap,
      borderRadius: _borderRadiusAsymmetricButton,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: _borderRadiusAsymmetricButton,
          color: paletteColors.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingLarge),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: AppText(
                  shouldTranslate ? translate(text) : text,
                  type: TextTypes.bodyBold,
                  color: paletteColors.textButton,
                ),
              ),
              const SizedBox(width: Dimens.paddingMedium),
              Icon(
                Icons.arrow_forward_ios,
                size: Dimens.iconBase,
                color: paletteColors.icons,
              )
            ],
          ),
        ),
      ),
    );
  }
}
