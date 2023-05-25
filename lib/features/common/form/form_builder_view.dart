import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/question.dart';
import 'package:inside_out/features/common/form/form_provider.dart';
import 'package:inside_out/features/common/form/views/structure_question_view.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class FormBuilderView extends StatelessWidget {
  final String? formId;
  final AppForm? form;
  final Function(AppForm form)? onAction;

  FormBuilderView({
    Key? key,
    this.formId,
    this.form,
    this.onAction,
  }) : super(key: key) {
    if (formId == null && form == null) {
      throw FlutterError('formId and form cannot be null at the same time');
    }
  }

  @override
  Widget build(BuildContext context) {
    final FormProvider formProvider = FormProvider(
      formId: formId,
      form: form,
    );

    return ChangeNotifierProvider<FormProvider>(
      create: (context) => formProvider,
      child: Consumer<FormProvider>(
        builder: (context, formProvider, child) {
          return Column(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (formProvider.form!.name != null)
                      AppText(
                        translate(formProvider.form!.name!),
                        type: TextTypes.titleBold,
                        color: Provider.of<ThemeService>(context).paletteColors.primary,
                      ),
                    const SizedBox(height: Dimens.paddingLarge),
                    ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: formProvider.form!.questions.length,
                      itemBuilder: (context, index) {
                        Question question = formProvider.form!.questions[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: question == formProvider.form!.questions.last ? 0 : Dimens.paddingLarge),
                          child: StructureQuestionView(
                            question: question,
                            onChange: (dynamic newValue) {
                              formProvider.setAnswer(questionId: question.id, value: newValue);
                            },
                          ),
                        );
                      },
                    ),
                    if (onAction != null) ...[
                      const SizedBox(height: Dimens.paddingXLarge),
                      AppButton(
                        text: formProvider.form!.actionText,
                        shouldTranslate: true,
                        onTap: () => onAction!(formProvider.form!),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
