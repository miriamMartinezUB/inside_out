import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/sign_up/privacy_policy_provider.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:inside_out/views/circular_progress.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final PrivacyPolicyProvider privacyPolicyProvider = PrivacyPolicyProvider(localeStorageService);
    final NavigationService navigationService = Provider.of<NavigationService>(context, listen: false);
    return ChangeNotifierProvider(
      create: (BuildContext context) => privacyPolicyProvider,
      child: Consumer<PrivacyPolicyProvider>(
        builder: (context, privacyPolicyProvider, child) {
          return PageWrapper(
            showAppBar: false,
            body: privacyPolicyProvider.isLoading
                ? const CircularProgress()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.paddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(Dimens.paddingLarge),
                            child: Center(
                              child: ImageView(
                                'logo.png',
                                height: Dimens.iconXXXLarge,
                              ),
                            ),
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppText(
                            translate('privacy_policy_title'),
                            type: TextTypes.title,
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppText(
                            translate('privacy_policy'),
                            type: TextTypes.bodyLight,
                            align: TextAlign.justify,
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppButton(
                            text: 'accept_and_continue',
                            onTap: () async {
                              await privacyPolicyProvider.acceptPrivacyPolicy();
                              navigationService.replace(Routes.welcome);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
