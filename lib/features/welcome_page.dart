import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_outlined_button.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = Provider.of<NavigationService>(context);
    return PageWrapper(
      showAppBar: false,
      body: Padding(
        padding: const EdgeInsets.all(Dimens.paddingLarge),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Center(
              child: AppText(
                translate('welcome_text'),
                align: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimens.paddingXLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppOutlinedButton(
                    text: 'login',
                    onTap: () => navigationService.navigateTo(Routes.login),
                  ),
                  const SizedBox(
                    height: Dimens.paddingLarge,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: AppText(
                          translate('not_register'),
                          type: TextTypes.subtitle,
                        ),
                      ),
                      const SizedBox(
                        height: Dimens.paddingLarge,
                      ),
                      AppTextButton(
                        text: 'sign_up',
                        color: Provider.of<ThemeService>(context).paletteColors.primary,
                        onTap: () => navigationService.navigateTo(Routes.signUp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
