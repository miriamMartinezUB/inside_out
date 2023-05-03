import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:provider/provider.dart';

class AppBackButton extends StatelessWidget {
  final Color? color;
  final Function? onPop;

  const AppBackButton({
    Key? key,
    this.color,
    this.onPop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.arrow_back_ios,
        color: color ?? Provider.of<ThemeService>(context).paletteColors.icons,
      ),
      onTap: () {
        if (onPop == null) {
          Provider.of<NavigationService>(context, listen: false).goBack();
        }
        onPop?.call();
      },
    );
  }
}
