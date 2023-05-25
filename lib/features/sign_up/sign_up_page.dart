import 'package:flutter/material.dart';
import 'package:inside_out/features/common/form/form_builder_view.dart';
import 'package:inside_out/features/sign_up/sign_up_provider.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/form_id.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/show_my_dialog.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    final NavigationService navigationService = Provider.of<NavigationService>(context, listen: false);
    final SignUpProvider signUpProvider = SignUpProvider(authService);
    return Provider(
      create: (BuildContext context) => signUpProvider,
      child: PageWrapper(
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
                      height: Dimens.iconXXXLarge,
                    ),
                  ),
                ),
                FormBuilderView(
                  formId: FormId.signUpFormId,
                  onAction: (form) async {
                    try {
                      await signUpProvider.signUp(form);
                      navigationService.navigateTo(Routes.home);
                    } on Exception catch (e) {
                      ShowMyDialog(title: 'Error - miss translation', text: e.toString()).show(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
