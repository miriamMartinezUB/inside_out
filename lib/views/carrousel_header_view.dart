import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class CarrouselHeaderView extends StatelessWidget {
  final bool isLeftIconDisabled;
  final bool isRightIconDisabled;
  final String? imagePath;
  final double? sizeImage;
  final Function() onPressLeftIcon;
  final Function() onPressRightIcon;
  final String title;
  final Color? colorTitle;
  final Color? activeIconColor;
  final bool isTitleDown;

  const CarrouselHeaderView({
    Key? key,
    required this.isLeftIconDisabled,
    required this.isRightIconDisabled,
    required this.onPressLeftIcon,
    required this.onPressRightIcon,
    required this.title,
    this.imagePath,
    this.sizeImage,
    this.colorTitle,
    this.activeIconColor,
    this.isTitleDown = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    Widget titleComponent = AppText(
      translate(title),
      align: isTitleDown ? TextAlign.center : TextAlign.start,
      color: colorTitle ?? paletteColors.textButton,
    );

    Widget image = ImageView(
      imagePath ?? '',
      height: sizeImage,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: isTitleDown ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: Dimens.iconMedium,
                color: isLeftIconDisabled ? paletteColors.inactive : activeIconColor ?? paletteColors.primary,
              ),
              onPressed: isLeftIconDisabled ? null : onPressLeftIcon,
            ),
            if (imagePath != null) image,
            if (!isTitleDown)
              Expanded(
                child: titleComponent,
              ),
            IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                size: Dimens.iconMedium,
                color: isRightIconDisabled ? paletteColors.inactive : activeIconColor ?? paletteColors.primary,
              ),
              onPressed: isRightIconDisabled ? null : onPressRightIcon,
            ),
          ],
        ),
        if (isTitleDown) titleComponent
      ],
    );
  }
}
