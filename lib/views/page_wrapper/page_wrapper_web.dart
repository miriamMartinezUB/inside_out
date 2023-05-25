import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/page_wrapper/app_drawer.dart';
import 'package:inside_out/views/page_wrapper/inside_out_app_bar.dart';
import 'package:provider/provider.dart';

class PageWrapper extends StatelessWidget {
  final Widget body;
  final bool isMainPage;
  final bool showAppBar;
  final String? appBarName;
  final Function? onPop;
  final Color? background;

  PageWrapper({
    Key? key,
    required this.body,
    this.isMainPage = false,
    this.showAppBar = false,
    this.appBarName,
    this.onPop,
    this.background,
  }) : super(key: key) {
    if (showAppBar && appBarName == null) {
      throw FlutterError('If showAppBar is true appBarName attribute is required');
    }
    if (showAppBar && !isMainPage) {
      throw FlutterError(' showAppBar and !isMainPage is not compatible');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    return WillPopScope(
      onWillPop: () async {
        onPop?.call();
        return navigationService.currentRoute == Routes.home ? false : !isMainPage;
      },
      child: Scaffold(
        backgroundColor: background ?? paletteColors.background,
        drawer: isMainPage ? const AppDrawer() : null,
        appBar: showAppBar
            ? InsideOutAppBar(
                isMainPage: isMainPage,
                onPop: onPop,
                appBarName: appBarName!,
              )
            : null,
        body: SafeArea(
          child: body,
        ),
      ),
    );
  }
}
