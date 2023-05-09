import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/main_flow/main_flow_provider.dart';
import 'package:inside_out/features/history/history_page.dart';
import 'package:inside_out/features/home/home_page.dart';
import 'package:inside_out/features/information/information_page.dart';
import 'package:inside_out/features/results/results_page.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class MainFlowPage extends StatelessWidget {
  const MainFlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeService themeService = Provider.of<ThemeService>(context);

    final MainFLowProvider mainFLowProvider = MainFLowProvider(themeService);

    return ChangeNotifierProvider<MainFLowProvider>(
      create: (context) => mainFLowProvider,
      child: Consumer<MainFLowProvider>(
        builder: (context, mainFLowProvider, child) {
          final PaletteColors paletteColors = themeService.paletteColors;

          /// The list of screens is inside of consumer and each one with
          /// the prefix new, to update it every time the theme change
          List<Widget> screens = [new HomePage(), new InformationPage(), new ResultsPage(), new HistoryPage()];

          return Scaffold(
            body: screens[mainFLowProvider.currentItemId],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              selectedLabelStyle: getTextStyle(paletteColors: paletteColors, type: TextTypes.tinyBody),
              unselectedLabelStyle: getTextStyle(paletteColors: paletteColors, type: TextTypes.tinyBody),
              backgroundColor: paletteColors.card,
              unselectedItemColor: paletteColors.textSubtitle,
              selectedItemColor: paletteColors.primary,
              currentIndex: mainFLowProvider.currentItemId,
              onTap: (int indexTapped) => mainFLowProvider.currentItemId = indexTapped,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: translate('home'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.info_outline_rounded),
                  label: translate('information'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.add_chart_sharp),
                  label: translate('results'),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.calendar_month_outlined),
                  label: translate('history'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
