import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class AppButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final GestureTapCallback? onTap;

  const AppButton({
    Key? key,
    required this.text,
    this.shouldTranslate = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Provider.of<ThemeService>(context).paletteColors.primary,
          borderRadius: BorderRadius.circular(Dimens.radiusMedium),
        ),
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
