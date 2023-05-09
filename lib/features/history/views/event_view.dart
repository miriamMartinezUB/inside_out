import 'package:flutter/material.dart';
import 'package:inside_out/features/history/domain/event.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

final BorderRadius _borderRadius = BorderRadius.circular(Dimens.radiusMedium);

class CardEventView extends StatelessWidget {
  final Event event;
  const CardEventView({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    return Padding(
      padding: const EdgeInsets.only(top: Dimens.paddingLarge),
      child: InkWell(
        onTap: () {
          //TODO
        },
        borderRadius: _borderRadius,
        child: Container(
          decoration: BoxDecoration(
            color: paletteColors.primary,
            borderRadius: _borderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //TODO
                AppText(
                  event.title,
                  color: paletteColors.textButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
