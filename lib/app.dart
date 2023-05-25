import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/views/image_view.dart';
import 'package:inside_out/views/page_wrapper/page_wrapper.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final NavigationService navigationService;

  @override
  void initState() {
    navigationService = Provider.of<NavigationService>(context, listen: false);
    navigationService.goToInitialRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: const Center(
        child: ImageView(
          'logo.png',
          height: Dimens.iconXXXLarge,
        ),
      ),
    );
  }
}
