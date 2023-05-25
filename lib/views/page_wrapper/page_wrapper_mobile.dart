import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
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
      throw FlutterError('showAppBar and !isMainPage is not compatible');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onPop?.call();
        return !isMainPage;
      },
      child: Scaffold(
        backgroundColor: background ?? Provider.of<ThemeService>(context).paletteColors.background,
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
