import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:provider/provider.dart';

Radius _radius = const Radius.circular(Dimens.radiusLarge);

class CardInformation extends StatelessWidget {
  const CardInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(Dimens.paddingLarge),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: _radius,
                    topRight: _radius,
                  ),
                  color: paletteColors.card,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: _radius,
                    bottomRight: _radius,
                  ),
                  color: paletteColors.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
