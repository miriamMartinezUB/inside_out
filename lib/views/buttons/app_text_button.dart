import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class AppTextButton extends StatelessWidget {
  final String text;
  final bool shouldTranslate;
  final Color? color;
  final GestureTapCallback? onTap;

  const AppTextButton({
    Key? key,
    required this.text,
    this.shouldTranslate = true,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(
          Provider.of<ThemeService>(context).paletteColors.secondary.withOpacity(0.5),
        ),
      ),
      onPressed: onTap,
      child: AppText(
        shouldTranslate ? translate(text) : text,
        type: TextTypes.body,
        color: color,
        align: TextAlign.center,
      ),
    );
  }
}