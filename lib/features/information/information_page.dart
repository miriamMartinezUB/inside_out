import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/data/database.dart';
import 'package:inside_out/domain/content/information_content.dart';
import 'package:inside_out/features/common/activity/activity_stepper_page.dart';
import 'package:inside_out/features/information/views/card_information.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:inside_out/views/wave_shape_app_bar.dart';
import 'package:provider/provider.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<InformationContent> informationContent = Database().content;
    final NavigationService navigationService = Provider.of<NavigationService>(context);

    return PageWrapper(
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? 'Information Page (miss translation)' : null, //TODO
      onPop: () {
        if (kIsWeb) {
          navigationService.goBack();
          navigationService.closeView();
        }
      },
      body: Column(
        children: [
          const WaveShapeAppBar(
            title: 'Descubre más miss translation',
            imagePath: 'descubre_mas.png',
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(Dimens.paddingLarge),
              itemCount: informationContent.length,
              itemBuilder: (context, index) {
                InformationContent content = informationContent[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      translate(content.title),
                      type: TextTypes.title,
                    ),
                    const SizedBox(height: Dimens.paddingMedium),
                    AppText(
                      translate(content.description),
                      type: TextTypes.bodyLight,
                    ),
                    GridView.count(
                      primary: false,
                      // We can use this:
                      crossAxisSpacing: Dimens.paddingMedium,
                      mainAxisSpacing: Dimens.paddingMedium,
                      //  or aspect ratio
                      shrinkWrap: true,
                      crossAxisCount: kIsWeb ? 5 : 2,
                      children: List.generate(
                        content.cards.length,
                        (indexCard) {
                          InformationCardContent card = content.cards[indexCard];
                          return CardInformation(
                            title: card.title,
                            isPrimary: card.isPrimary,
                            onTap: () {
                              Provider.of<NavigationService>(context, listen: false).navigateTo(
                                Routes.activity,
                                arguments: ActivityStepperPageArgs(
                                  activityId: card.activityId,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    if (content != informationContent.last) const SizedBox(height: Dimens.paddingLarge),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
