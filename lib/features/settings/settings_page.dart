import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/form/views/structure_question_view.dart';
import 'package:inside_out/features/settings/settings_provider.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/firebase/firebase_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/storage/locale_storage_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/show_my_dialog.dart';
import 'package:inside_out/views/wave_shape_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageService languageService = Provider.of<LanguageService>(context);
    final FirebaseService firebaseService = Provider.of<FirebaseService>(context);
    final LocaleStorageService localeStorageService = Provider.of<LocaleStorageService>(context);
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final AuthService authService = Provider.of<AuthService>(context);
    final NavigationService navigationService = Provider.of<NavigationService>(context, listen: false);
    final PaletteColors paletteColors = themeService.paletteColors;
    final SettingsProvider settingsProvider = SettingsProvider(
      languageService: languageService,
      themeService: themeService,
      firebaseService: firebaseService,
      authService: authService,
      localeStorageService: localeStorageService,
    );
    return ChangeNotifierProvider<SettingsProvider>(
      create: (BuildContext context) => settingsProvider,
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return PageWrapper(
            showAppBar: false,
            isMainPage: false,
            body: Column(
              children: [
                WaveShapeAppBar(
                  key: Key(const Uuid().v4()),
                  title: translate('settings'),
                  imagePath: 'settings.png',
                  isMainPage: false,
                ),
                const SizedBox(height: Dimens.paddingXLarge),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.paddingLarge),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StructureQuestionView(
                            question: settingsProvider.selectLanguageQuestion,
                            onChange: (value) async => await settingsProvider.setLanguage(value),
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          StructureQuestionView(
                            question: settingsProvider.selectThemeQuestion,
                            onChange: (value) async => await settingsProvider.setTheme(value),
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppTextButton(
                            text: translate('send_feedback'),
                            icon: Icons.email_rounded,
                            onTap: () async {
                              await settingsProvider.sendEmail();
                            },
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppTextButton(
                            text: translate('privacy_policy_title'),
                            icon: Icons.privacy_tip_rounded,
                            onTap: () {
                              navigationService.navigateTo(Routes.privacyPolicy);
                            },
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppTextButton(
                            text: translate('logout'),
                            icon: Icons.logout_rounded,
                            onTap: () async {
                              await settingsProvider.logout();
                            },
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppTextButton(
                            text: translate('delete_account'),
                            color: paletteColors.textError,
                            icon: Icons.delete,
                            onTap: () {
                              ShowMyDialog(
                                  title: translate('remove_account_model_title'),
                                  text: translate('remove_account_model_text'),
                                  actions: [
                                    ContentAction(
                                      textAction: 'accept',
                                      onPress: () async {
                                        await settingsProvider.deleteAccount();
                                        navigationService.replace(Routes.initialRoute);
                                      },
                                    ),
                                    ContentAction(
                                      textAction: 'cancel',
                                      onPress: () async {
                                        navigationService.closeView();
                                      },
                                    ),
                                  ]).show(context);
                            },
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
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
