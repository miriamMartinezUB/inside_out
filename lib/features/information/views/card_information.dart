import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

Radius _radius = const Radius.circular(Dimens.radiusLarge);

class CardInformation extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const CardInformation({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(Dimens.paddingLarge),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: _radius,
                  topRight: _radius,
                ),
                color: paletteColors.secondary,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(Dimens.paddingMedium),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: _radius,
                  bottomRight: _radius,
                ),
                color: paletteColors.primary,
              ),
              child: AppText(
                title,
                color: paletteColors.textButton,
                type: TextTypes.smallBodyMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
