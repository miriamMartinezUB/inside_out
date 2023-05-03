import 'package:flutter/material.dart';
import 'package:inside_out/features/common/form/form_builder_view.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/form_id.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/buttons/app_button.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              const FormBuilderView(
                formId: FormId.signUpFormId,
              ),
              const SizedBox(
                height: Dimens.paddingXLarge,
              ),
              const AppButton(text: 'sign_up'),
            ],
          ),
        ),
      ),
    );
  }
}
