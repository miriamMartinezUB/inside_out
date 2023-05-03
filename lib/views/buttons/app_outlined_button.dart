import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final GestureTapCallback? onTap;

  const AppOutlinedButton({
    Key? key,
    required this.text,
    this.shouldTranslate = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return OutlinedButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(paletteColors.background),
        foregroundColor: MaterialStateProperty.all(paletteColors.primary),
        side: MaterialStateProperty.all(
          BorderSide(color: paletteColors.primary),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.radiusMedium),
          ),
        ),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingLarge),
          child: AppText(
            shouldTranslate ? translate(text) : text,
            type: TextTypes.body,
            align: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
