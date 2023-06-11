import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/results/results_provider.dart';
import 'package:inside_out/features/results/views/carrousel_content_view.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/circular_progress.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/wave_shape_app_bar.dart';
import 'package:provider/provider.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    final FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final ResultsProvider resultsProvider =
        ResultsProvider(firebaseService: firebaseService, localeStorageService: localeStorageService);

    return ChangeNotifierProvider<ResultsProvider>(
      create: (BuildContext context) => resultsProvider,
      child: Consumer<ResultsProvider>(
        builder: (context, resultsProvider, child) {
          if (resultsProvider.loading) {
            return const CircularProgress();
          }
          return PageWrapper(
            showAppBar: kIsWeb,
            isMainPage: true,
            appBarName: kIsWeb ? translate('results') : null,
            onPop: () {
              if (kIsWeb) {
                navigationService.goBack();
                navigationService.closeView();
              }
            },
            body: Column(
              children: [
                if (!kIsWeb)
                  const WaveShapeAppBar(
                    title: 'Results',
                    imagePath: 'results_image.png',
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.paddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimens.paddingXLarge),
                          CarrouselContentView(
                            key: Key(resultsProvider.emotionsGrid.id),
                            content: resultsProvider.emotionsGrid,
                          ),
                          if (resultsProvider.objectivesGrid != null) ...[
                            const SizedBox(height: Dimens.paddingLarge),
                            CarrouselContentView(
                              key: Key(resultsProvider.objectivesGrid!.id),
                              content: resultsProvider.objectivesGrid!,
                            ),
                          ],
                          if (resultsProvider.principlesAndValuesGrid != null) ...[
                            const SizedBox(height: Dimens.paddingLarge),
                            CarrouselContentView(
                              key: Key(resultsProvider.principlesAndValuesGrid!.id),
                              content: resultsProvider.principlesAndValuesGrid!,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
