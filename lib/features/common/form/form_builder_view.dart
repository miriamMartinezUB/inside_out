import 'package:flutter/material.dart';
import 'package:inside_out/domain/form.dart';
import 'package:inside_out/domain/question/question.dart';
import 'package:inside_out/features/common/form/form_provider.dart';
import 'package:inside_out/features/common/form/views/structure_question_view.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:provider/provider.dart';

class FormBuilderView extends StatelessWidget {
  final String formId;
  final Function(AppForm form)? onAction;

  const FormBuilderView({
    Key? key,
    required this.formId,
    this.onAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormProvider formProvider = FormProvider(formId);

    return ChangeNotifierProvider<FormProvider>(
      create: (context) => formProvider,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: formProvider.form.questions.length,
            itemBuilder: (context, index) {
              Question question = formProvider.form.questions[index];
              return Padding(
                padding:
                    EdgeInsets.only(bottom: question == formProvider.form.questions.last ? 0 : Dimens.paddingLarge),
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
              text: formProvider.form.actionText,
              shouldTranslate: true,
              onTap: onAction!(formProvider.form),
            ),
          ]
        ],
      ),
    );
  }
}
