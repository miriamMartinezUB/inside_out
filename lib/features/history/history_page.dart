import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/history/views/calendar_view.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/buttons/app_settings_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    return PageWrapper(
      background: paletteColors.primary,
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? 'history' : null,
      onPop: () {
        if (kIsWeb) {
          navigationService.goBack();
          navigationService.closeView();
        }
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: Dimens.paddingXLarge),
                  Expanded(
                    child: AppText(
                      translate('history'),
                      type: TextTypes.titleBold,
                      color: paletteColors.textAppBar,
                    ),
                  ),
                  const AppSettingsButton(),
                  const SizedBox(width: Dimens.paddingLarge),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(Dimens.radiusXLarge),
                  topRight: Radius.circular(Dimens.radiusXLarge),
                ),
                color: paletteColors.background,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimens.paddingXLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// The random key is important to refresh it every time and get refresh
                    /// after change theme
                    CalendarView(key: Key(const Uuid().v4())),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
