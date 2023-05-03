import 'package:flutter/material.dart';
import 'package:inside_out/features/common/form/form_builder_view.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/form_id.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = Provider.of<NavigationService>(context, listen: false);
    return PageWrapper(
      showAppBar: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Dimens.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBackButton(color: Provider.of<ThemeService>(context).paletteColors.textSubtitle),
              const Padding(
                padding: EdgeInsets.all(Dimens.paddingLarge),
                child: Center(
                  child: ImageView(
                    'logo.png',
                    height: Dimens.iconXLarge,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FormBuilderView(
                    formId: FormId.loginFormId,
                  ),
                  AppTextButton(
                    text: 'forgot_password',
                    color: Provider.of<ThemeService>(context).paletteColors.textSubtitle,
                    onTap: () => navigationService.navigateTo(Routes.forgotPassword),
                  ),
                ],
              ),
              const SizedBox(
                height: Dimens.paddingLarge,
              ),
              AppButton(
                text: 'login',
                onTap: () => navigationService.navigateTo(Routes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}