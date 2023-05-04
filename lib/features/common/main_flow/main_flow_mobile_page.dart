import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/main_flow/main_flow_provider.dart';
import 'package:inside_out/features/history/history_page.dart';
import 'package:inside_out/features/home/home_page.dart';
import 'package:inside_out/features/information/information_page.dart';
import 'package:inside_out/features/results/results_page.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:provider/provider.dart';

class MainFlowPage extends StatelessWidget {
  const MainFlowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;

    final MainFLowProvider mainFLowProvider = MainFLowProvider();
    List<Widget> screens = [const HomePage(), const InformationPage(), const ResultsPage(), const HistoryPage()];

    return ChangeNotifierProvider<MainFLowProvider>(
      create: (context) => mainFLowProvider,
      child: Consumer<MainFLowProvider>(
        builder: (context, mainFLowProvider, child) {
          return Scaffold(
            body: screens[mainFLowProvider.currentItemId],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
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
