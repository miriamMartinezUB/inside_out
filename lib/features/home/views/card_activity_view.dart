import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

abstract class CardActivity extends StatelessWidget {
  final Function()? onTap;
  const CardActivity({Key? key, required this.onTap}) : super(key: key);

  factory CardActivity.howDoYouFeel(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return _CardActivity(
      onTap: () {},
      alignment: Alignment.bottomRight,
      imagePath: 'card_how_do_you_feel.png',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            translate('how_do_you_feel_card_title'),
            type: TextTypes.subtitleBold,
          ),
          const SizedBox(height: Dimens.paddingMedium),
          Row(
            children: [
              Flexible(
                child: AppText(
                  translate('how_do_you_feel_card_subtitle'),
                  color: paletteColors.primary,
                  type: TextTypes.smallBodyMedium,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: paletteColors.primary,
                size: Dimens.iconSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  factory CardActivity.forgivenessDiet({
    required int day,
    required bool done,
    required BuildContext context,
  }) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return _CardActivityWithIconLeft(
      onTap: () {},
      done: done,
      imagePath: 'forgiveness_diet_card.png',
      title: AppText(
        'Gestiona tu rabia (miss translation)',
        type: TextTypes.subtitleBold,
        color: paletteColors.primary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            'Día $day/7 (miss translation)',
            type: TextTypes.smallBodyMedium,
          ),
          const SizedBox(height: Dimens.paddingMedium),
          LinearProgressIndicator(
            value: day / 7,
          ),
        ],
      ),
    );
  }
}

class _CardActivityWithIconLeft extends CardActivity {
  final Widget title;
  final Widget child;
  final bool done;
  final String imagePath;

  const _CardActivityWithIconLeft({
    Key? key,
    required this.title,
    required this.child,
    required this.done,
    required this.imagePath,
    required Function()? onTap,
  }) : super(key: key, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          padding: const EdgeInsets.only(left: Dimens.paddingLarge),
          child: _CardActivity(
            onTap: onTap,
            alignment: Alignment.topRight,
            imagePath: imagePath,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: Dimens.iconLarge),
                  child: title,
                ),
                const SizedBox(height: Dimens.paddingMedium),
                child,
              ],
            ),
          ),
        ),
        Stack(
          children: [
            Icon(
              Icons.circle,
              color: paletteColors.card,
              size: Dimens.iconMedium,
            ),
            Icon(
              done ? Icons.check_circle : Icons.circle_outlined,
              color: paletteColors.primary,
              size: Dimens.iconMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class _CardActivity extends CardActivity {
  final Widget child;
  final String imagePath;
  final Alignment alignment;

  const _CardActivity({
    Key? key,
    required this.child,
    required this.imagePath,
    required this.alignment,
    required Function()? onTap,
  }) : super(key: key, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Stack(
        alignment: alignment,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: alignment == Alignment.topRight ? Dimens.paddingXLarge : 0,
              bottom: alignment == Alignment.bottomRight ? Dimens.paddingXLarge : 0,
            ),
            padding: const EdgeInsets.all(Dimens.paddingLarge),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimens.radiusMedium),
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
            child: Padding(
              padding: const EdgeInsets.only(right: Dimens.iconLarge - Dimens.paddingLarge),
              child: child,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingMedium),
            child: ImageView(
              imagePath,
              width: Dimens.iconLarge,
            ),
          ),
        ],
      ),
    );
  }
}