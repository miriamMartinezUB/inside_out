import 'package:flutter/material.dart';
import 'package:inside_out/features/common/activity/activity_stepper_provider.dart';
import 'package:inside_out/features/common/form/form_builder_view.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ActivityStepperPageArgs {
  final String activityId;

  ActivityStepperPageArgs({required this.activityId});
}

class ActivityStepperPage extends StatelessWidget {
  final ActivityStepperPageArgs activityStepperPageArgs;

  const ActivityStepperPage({
    Key? key,
    required this.activityStepperPageArgs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final ActivityStepperProvider activityStepperProvider = ActivityStepperProvider(activityStepperPageArgs.activityId);

    return ChangeNotifierProvider<ActivityStepperProvider>(
      create: (BuildContext context) => activityStepperProvider,
      child: Consumer<ActivityStepperProvider>(
        builder: (context, activityStepperProvider, child) {
          int currentIndexStep = activityStepperProvider.currentIndexStep;
          return PageWrapper(
            body: Padding(
              padding: const EdgeInsets.all(Dimens.paddingLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBackButton(
                    color: paletteColors.primary,
                  ),
                  const SizedBox(height: Dimens.paddingLarge),
                  StepProgressIndicator(
                    totalSteps: activityStepperProvider.steps.length,
                    selectedColor: paletteColors.primary,
                    size: Dimens.borderThickness,
                    unselectedColor: paletteColors.inactive,
                    currentStep: currentIndexStep + 1,
                  ),
                  const SizedBox(height: Dimens.paddingLarge),
                  Expanded(
                    child: SingleChildScrollView(
                      child: FormBuilderView(
                        key: Key(activityStepperProvider.steps[currentIndexStep].form.id),
                        form: activityStepperProvider.steps[currentIndexStep].form,
                        onAction: (appForm) {
                          if (currentIndexStep == activityStepperProvider.steps.length - 1) {
                            //TODO
                            Provider.of<NavigationService>(context, listen: false).goBack();
                          } else {
                            activityStepperProvider.setActivity(appForm);
                            activityStepperProvider.setCurrentStep(currentIndexStep + 1);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
