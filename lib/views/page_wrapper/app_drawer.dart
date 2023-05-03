import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/app_divider.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);

    return SafeArea(
      child: Drawer(
        backgroundColor: paletteColors.background,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
                child: Column(
                  children: [
                    DrawerItem(
                      text: translate('home'),
                      iconData: Icons.home_outlined,
                      color: paletteColors.icons,
                      onTap: () => navigationService.replace(Routes.home),
                    ),
                    DrawerItem(
                      text: translate('information'),
                      iconData: Icons.info_outline_rounded,
                      color: paletteColors.icons,
                      onTap: () => navigationService.navigateTo(Routes.information),
                    ),
                    DrawerItem(
                      text: translate('results'),
                      iconData: Icons.add_chart_sharp,
                      color: paletteColors.icons,
                      onTap: () => navigationService.navigateTo(Routes.results),
                    ),
                    DrawerItem(
                      text: translate('history'),
                      iconData: Icons.history,
                      color: paletteColors.icons,
                      onTap: () => navigationService.navigateTo(Routes.history),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Function() onTap;
  final Color? color;

  const DrawerItem({
    Key? key,
    required this.text,
    required this.iconData,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Provider.of<ThemeService>(context).paletteColors.primary,
      child: Column(
        children: [
          ListTile(
            title: AppText(
              translate(text),
              type: TextTypes.body,
              color: color,
            ),
            leading: Icon(
              iconData,
              color: color,
            ),
          ),
          const AppDivider(),
        ],
      ),
    );
  }
}
