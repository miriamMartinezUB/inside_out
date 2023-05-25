import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/form/views/structure_question_view.dart';
import 'package:inside_out/features/settings/settings_provider.dart';
import 'package:inside_out/infrastructure/auth_service.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/resources/routes.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/wave_shape_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageService languageService = Provider.of<LanguageService>(context);
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final AuthService authService = Provider.of<AuthService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    final SettingsProvider settingsProvider = SettingsProvider(
      languageService: languageService,
      themeService: themeService,
      authService: authService,
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
                  title: 'Settings miss translation',
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
                            onChange: (value) => settingsProvider.setLanguage(value),
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          StructureQuestionView(
                            question: settingsProvider.selectThemeQuestion,
                            onChange: (value) => settingsProvider.setTheme(value),
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          StructureQuestionView(
                            question: settingsProvider.sendFeedbackQuestion,
                            onChange: (value) => settingsProvider.feedback = value,
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppButton(
                            text: translate('send_feedback_button'),
                            onTap: () {
                              //TODO show dialog or snack bar
                              settingsProvider.sendFeedback();
                              //TODO disabled if feedback is null or empty
                            },
                          ),
                          const SizedBox(height: Dimens.paddingLarge),
                          AppTextButton(
                            text: translate('logout'),
                            color: paletteColors.textError,
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
                              //TODO show dialog or snack bar
                              settingsProvider.deleteAccount();
                              Provider.of<NavigationService>(context, listen: false).replace(Routes.initialRoute);
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
