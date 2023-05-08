import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:provider/provider.dart';

class AppSettingsButton extends StatelessWidget {
  const AppSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: Icon(Icons.settings, color: paletteColors.icons),
      ),
      onTap: () => Provider.of<NavigationService>(context, listen: false).navigateTo(Routes.settings),
    );
  }
}
