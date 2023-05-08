import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:inside_out/views/wave_shape_app_bar.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    return PageWrapper(
      showAppBar: kIsWeb,
      isMainPage: true,
      appBarName: kIsWeb ? 'Results Page (miss translation)' : null, //TODO
      onPop: () {
        navigationService.goBack();
        navigationService.closeView();
      },
      body: Column(
        children: const [
          WaveShapeAppBar(
            title: 'Results',
            imagePath: 'descubre_mas.png',
          ),
          SizedBox(height: Dimens.paddingXLarge),
          Center(
            child: AppText(
              'NOT IMPLEMENTED',
            ),
          ),
        ],
      ),
    );
  }
}
