import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/texts.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:provider/provider.dart';

class WaveShapeAppBar extends StatelessWidget {
  final String title;
  final String imagePath;

  const WaveShapeAppBar({
    Key? key,
    required this.title,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ClipPath(
          clipper: ProsteBezierCurve(
            position: ClipPosition.bottom,
            list: [
              BezierCurveSection(
                start: const Offset(0, 125),
                top: Offset(screenWidth / 4, 150),
                end: Offset(screenWidth / 2, 135),
              ),
              BezierCurveSection(
                start: Offset(screenWidth / 2, 125),
                top: Offset(screenWidth / 4 * 3, 100),
                end: Offset(screenWidth, 90),
              ),
            ],
          ),
          child: Container(
            width: double.infinity,
            height: 150,
            color: paletteColors.primary,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimens.paddingXXLarge,
                horizontal: Dimens.paddingXLarge,
              ),
              child: AppText(
                title,
                color: paletteColors.textAppBar,
                type: TextTypes.titleBold,
              ),
            ),
          ),
        ),
        ImageView(
          imagePath,
          height: Dimens.iconLarge,
        ),
      ],
    );
  }
}
