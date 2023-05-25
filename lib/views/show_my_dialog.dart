import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/navigation/navigation_service.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/views/buttons/app_text_button.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class ShowMyDialog {
  final String? title;
  final String text;
  final List<ContentAction>? actions;

  late final Color _colorActions;

  ShowMyDialog({
    required this.title,
    required this.text,
    this.actions,
  });

  Future<void> show(BuildContext context) async {
    _colorActions = Provider.of<ThemeService>(context, listen: false).paletteColors.active;
    List<ContentAction>? actions = this.actions;

    actions ??= [
      ContentAction(
        textAction: 'accept - miss translation',
        onPress: () {
          Provider.of<NavigationService>(context, listen: false).closeView();
        },
      ),
    ];

    final List<Widget> customActions = _getActions(actions, _colorActions);

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title == null
              ? null
              : AppText(
                  title!,
                  type: TextTypes.smallBodyMedium,
                ),
          content: AppText(
            text,
            type: TextTypes.smallBody,
          ),
          actions: customActions,
        );
      },
    );
  }

  List<Widget> _getActions(List<ContentAction> actions, Color colorActions) {
    List<Widget> result = [];
    for (ContentAction contentAction in actions) {
      result.add(
        AppTextButton(
          text: contentAction.textAction,
          onTap: contentAction.onPress,
          color: contentAction.color ?? _colorActions,
        ),
      );
    }
    return result;
  }
}

class ContentAction {
  final String textAction;
  final Color? color;
  final Function() onPress;

  ContentAction({required this.textAction, required this.onPress, this.color});
}
