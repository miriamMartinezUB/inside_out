import 'package:flutter/material.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

class FreeTextQuestionView extends StatefulWidget {
  final String? initialText;
  final Function(String) onChanged;
  final bool isLong;

  const FreeTextQuestionView({
    Key? key,
    this.initialText,
    required this.onChanged,
    this.isLong = false,
  }) : super(key: key);

  @override
  State<FreeTextQuestionView> createState() => _FreeTextQuestionViewState();
}

class _FreeTextQuestionViewState extends State<FreeTextQuestionView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    final PaletteColors paletteColors = Provider.of<ThemeService>(context).paletteColors;
    final TextStyle style = getTextStyle(paletteColors: paletteColors);

    return TextField(
      controller: _controller,
      style: style,
      maxLines: widget.isLong ? 5 : 1,
      cursorColor: paletteColors.primary,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: Dimens.borderThickness,
            color: paletteColors.primary,
          ),
        ),
        border: const OutlineInputBorder(),
      ),
      onChanged: widget.onChanged,
    );
  }
}
