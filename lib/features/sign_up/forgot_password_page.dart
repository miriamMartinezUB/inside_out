import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/form/form_builder_view.dart';
import 'package:inside_out/features/sign_up/forgot_password_provider.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/form_id.dart';
import 'package:inside_out/utils/exception_text.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/show_my_dialog.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    final NavigationService navigationService = Provider.of<NavigationService>(context, listen: false);
    final ForgotPasswordProvider forgotPasswordProvider = ForgotPasswordProvider(authService);

    return Provider(
      create: (BuildContext context) => forgotPasswordProvider,
      child: PageWrapper(
        showAppBar: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Dimens.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(color: Provider.of<ThemeService>(context).paletteColors.textSubtitle),
                FormBuilderView(
                  formId: FormId.forgotPasswordFormId,
                  onAction: (form) async {
                    try {
                      await forgotPasswordProvider.recoverPassword(form);
                      ShowMyDialog(
                        title: translate('recover_password_model_title'),
                        text: translate('recover_password_model_text'),
                        actions: [
                          ContentAction(
                            textAction: 'send_again',
                            onPress: () async {
                              await forgotPasswordProvider.recoverPassword(form);
                            },
                          ),
                          ContentAction(
                            textAction: 'return_login',
                            onPress: () {
                              navigationService.closeView();
                              navigationService.goBack();
                            },
                          ),
                        ],
                      ).show(context);
                    } catch (e) {
                      ShowMyDialog(
                        title: translate('error'),
                        text: translate(ExceptionText(e.toString()).getMessage()),
                      ).show(context);
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
