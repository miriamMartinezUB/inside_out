import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/main_flow/main_flow_item_id.dart';
import 'package:inside_out/features/common/main_flow/main_flow_provider.dart';
import 'package:inside_out/features/home/views/card_activity_view.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/app_divider.dart';
import 'package:inside_out/views/buttons/app_asymmetric_button.dart';
import 'package:inside_out/views/buttons/app_settings_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    return PageWrapper(
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? 'Home (miss translation)' : null, //TODO
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.paddingLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimens.paddingXLarge),
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            '${translate('hi')}Miriam',
                            type: TextTypes.titleBold,
                            color: paletteColors.primary,
                          ),
                        ),
                        AppSettingsButton(
                          color: paletteColors.primary,
                        )
                      ],
                    ),
                    const SizedBox(height: Dimens.paddingXLarge),
                    CardActivity.howDoYouFeel(context),
                    const SizedBox(height: Dimens.paddingLarge),
                    const AppDivider(),
                    const SizedBox(height: Dimens.paddingLarge),
                    AppText(
                      translate('activities_title'),
                      type: TextTypes.subtitleBold,
                      color: paletteColors.secondary,
                    ),
                    CardActivity.forgivenessDiet(
                      day: 2,
                      done: true,
                      context: context,
                    ),
                    const SizedBox(height: Dimens.paddingLarge),
                    CardActivity.forgivenessDiet(
                      day: 1,
                      done: false,
                      context: context,
                    ),
                    const SizedBox(height: Dimens.paddingXLarge),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: Dimens.paddingXLarge),
          AppAsymmetricButton(
            text: 'see_results_button',
            onTap: () {
              if (kIsWeb) {
                Provider.of<NavigationService>(context, listen: false).navigateTo(Routes.results);
              } else {
                Provider.of<MainFLowProvider>(context, listen: false).currentItemId = MainFlowItemId.results;
              }
            },
          ),
          const SizedBox(height: Dimens.paddingXLarge),
        ],
      ),
    );
  }
}
