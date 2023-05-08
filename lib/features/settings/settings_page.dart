import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/features/common/form/views/structure_question_view.dart';
import 'package:inside_out/features/settings/settings_provider.dart';
import 'package:inside_out/infrastructure/language_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/wave_shape_app_bar.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LanguageService languageService = Provider.of<LanguageService>(context);
    final ThemeService themeService = Provider.of<ThemeService>(context);
    final PaletteColors paletteColors = themeService.paletteColors;
    final SettingsProvider settingsProvider = SettingsProvider(
      languageService: languageService,
      themeService: themeService,
    );
    return PageWrapper(
      showAppBar: false,
      isMainPage: false,
      body: Column(
        children: [
          const WaveShapeAppBar(
            title: 'Settings',
            imagePath: 'settings.png',
            isMainPage: false,
          ),
          const SizedBox(height: Dimens.paddingXLarge),
          ChangeNotifierProvider<SettingsProvider>(
            create: (BuildContext context) => settingsProvider,
            child: Consumer<SettingsProvider>(builder: (context, settingsProvider, child) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(Dimens.paddingLarge),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StructureQuestionView(
                          question: settingsProvider.selectLanguageQuestion,
                          onChange: (value) => settingsProvider.setSelectLanguageQuestion(value),
                        ),
                        const SizedBox(height: Dimens.paddingLarge),
                        StructureQuestionView(
                          question: settingsProvider.selectThemeQuestion,
                          onChange: (value) => settingsProvider.setSelectThemeQuestion(value),
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
                          text: translate('remove_all_data'),
                          color: paletteColors.textError,
                          icon: Icons.delete,
                          onTap: () {
                            //TODO show dialog or snack bar
                            settingsProvider.removeAllData();
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
                          },
                        ),
                        const SizedBox(height: Dimens.paddingLarge),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
