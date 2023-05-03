import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/views/buttons/app_back_button.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      showAppBar: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBackButton(color: Provider.of<ThemeService>(context).paletteColors.textSubtitle),
            const Center(
              child: AppText('NOT IMPLEMENTED'),
            ),
          ],
        ),
      ),
    );
  }
}
