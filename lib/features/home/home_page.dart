import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/activity.dart';
import 'package:inside_out/features/common/main_flow/main_flow_item_id.dart';
import 'package:inside_out/features/common/main_flow/main_flow_provider.dart';
import 'package:inside_out/features/home/home_provider.dart';
import 'package:inside_out/features/home/views/card_activity_view.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/app_divider.dart';
import 'package:inside_out/views/buttons/app_asymmetric_button.dart';
import 'package:inside_out/views/buttons/app_settings_button.dart';
import 'package:inside_out/views/circular_progress.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final HomeProvider homeProvider = HomeProvider(
      firebaseService: firebaseService,
      localeStorageService: localeStorageService,
    );
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => homeProvider,
      child: PageWrapper(
        showAppBar: kIsWeb,
        isMainPage: true,
        appBarName: kIsWeb ? translate('home') : null,
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
                              '${translate('hi')}${homeProvider.name}',
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
                      CardActivity.howDoYouFeel(
                        context,
                        (activityAnswer) => homeProvider.onFinishThoughtDiary(activityAnswer),
                      ),
                      const SizedBox(height: Dimens.paddingLarge),
                      const AppDivider(),
                      const SizedBox(height: Dimens.paddingLarge),
                      AppText(
                        translate('activities_title'),
                        type: TextTypes.subtitleBold,
                        color: paletteColors.primary,
                      ),
                      StreamBuilder<List<TemporaryActivity>>(
                          stream: homeProvider.activities$,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgress();
                            }
                            if (snapshot.data!.isEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: Dimens.paddingLarge),
                                  AppText(
                                    translate('no_activities_text'),
                                    color: paletteColors.textSubtitle,
                                    type: TextTypes.bodyLight,
                                  ),
                                ],
                              );
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              padding: const EdgeInsets.symmetric(vertical: Dimens.paddingLarge),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                TemporaryActivity activity = snapshot.data![index];
                                late CardActivity card;
                                if (activity is ForgivenessDietActivity) {
                                  card = CardActivity.forgivenessDiet(
                                    day: activity.currentDay,
                                    done: activity.isDone,
                                    context: context,
                                    onFinish: (activityAnswer) => homeProvider.onFinishForgiveness(activityAnswer),
                                  );
                                } else {
                                  card = CardActivity.prioritisationPrinciples(
                                    done: activity.isDone,
                                    context: context,
                                    onFinish: (activityAnswer) =>
                                        homeProvider.onFinishPrioritisationPrinciples(activityAnswer),
                                  );
                                }
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: index == snapshot.data!.length - 1 ? 0 : Dimens.paddingLarge),
                                  child: card,
                                );
                              },
                            );
                          }),
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
      ),
    );
  }
}
