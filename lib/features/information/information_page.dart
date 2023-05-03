import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:inside_out/features/information/views/card_information.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:provider/provider.dart';

class InformationPage extends StatelessWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = Provider.of<NavigationService>(context);

    return PageWrapper(
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? 'Information Page (miss translation)' : null, //TODO
      onPop: () {
        navigationService.goBack();
        navigationService.closeView();
      },
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(Dimens.paddingLarge),
              crossAxisSpacing: Dimens.paddingMedium,
              mainAxisSpacing: Dimens.paddingMedium,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: const <Widget>[
                CardInformation(),
                CardInformation(),
                CardInformation(),
                CardInformation(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
