import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/form/form_builder_view.dart';
import 'package:inside_out/features/sign_up/login_provider.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/form_id.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/utils/exception_text.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/circular_progress.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/show_my_dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);
    final NavigationService navigationService = Provider.of<NavigationService>(context, listen: false);
    final LanguageService languageService = Provider.of<LanguageService>(context, listen: false);
    final ThemeService themeService = Provider.of<ThemeService>(context, listen: false);
    final LoginProvider loginProvider = LoginProvider(
      authService: authService,
      themeService: themeService,
      languageService: languageService,
    );
    return ChangeNotifierProvider(
      create: (BuildContext context) => loginProvider,
      child: Consumer<LoginProvider>(
        builder: (context, loginProvider, child) {
          return PageWrapper(
            showAppBar: false,
            body: loginProvider.isLoading
                ? const CircularProgress()
                : SingleChildScrollView(
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
                            formId: FormId.loginFormId,
                            onAction: (form) async {
                              try {
                                await loginProvider.logIn(form);
                              } catch (e) {
                                ShowMyDialog(
                                  title: 'Error - miss translation',
                                  text: translate(ExceptionText(e.toString()).getMessage()),
                                ).show(context);
                              }
                            },
                          ),
                          AppTextButton(
                            text: 'forgot_password',
                            color: themeService.paletteColors.textSubtitle,
                            onTap: () => navigationService.navigateTo(Routes.forgotPassword),
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
