import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:provider/provider.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: Dimens.borderThickness,
      color: Provider.of<ThemeService>(context).paletteColors.primary,
    );
  }
}
