import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/buttons/app_settings_button.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class InsideOutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isMainPage;
  final String appBarName;
  final Function? onPop;

  const InsideOutAppBar({
    Key? key,
    required this.isMainPage,
    required this.appBarName,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    return AppBar(
      backgroundColor: paletteColors.primary,
      centerTitle: true,
      iconTheme: IconThemeData(color: paletteColors.icons),
      leading: !isMainPage ? AppBackButton(onPop: onPop) : null,
      actions: isMainPage ? [const AppSettingsButton()] : [const _HomeButton()],
      title: AppText(
        appBarName,
        type: TextTypes.title,
        align: TextAlign.center,
        color: paletteColors.textAppBar,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
        child: Icon(Icons.home, color: paletteColors.primary),
      ),
      onTap: () => Provider.of<NavigationService>(context, listen: false).replace(Routes.home),
    );
  }
}
