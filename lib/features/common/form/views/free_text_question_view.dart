import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:inside_out/infrastructure/theme_service.dart';
import 'package:inside_out/resources/dimens.dart';
import 'package:inside_out/resources/palette_colors.dart';
import 'package:inside_out/views/texts.dart';
import 'package:provider/provider.dart';

BorderRadius _borderRadius = BorderRadius.circular(Dimens.radiusLarge);

class FreeTextQuestionView extends StatefulWidget {
  final String? initialText;
  final String? hint;
  final Function(String) onChanged;
  final bool isLong;
  final bool isObscureText;
  final int? maxLength;
  final int? minLines;

  const FreeTextQuestionView({
    Key? key,
    required this.onChanged,
    required this.isObscureText,
    this.initialText,
    this.hint,
    this.isLong = false,
    this.maxLength,
    this.minLines,
  }) : super(key: key);

  @override
  State<FreeTextQuestionView> createState() => _FreeTextQuestionViewState();
}

class _FreeTextQuestionViewState extends State<FreeTextQuestionView> {
  late final TextEditingController _controller;
  late final PaletteColors paletteColors;
  late final TextStyle style;
  late bool isObscureText;

  @override
  void initState() {
    super.initState();
    isObscureText = widget.isObscureText;
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void didChangeDependencies() {
    paletteColors = Provider.of<ThemeService>(context).paletteColors;
    style = getTextStyle(paletteColors: paletteColors);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      style: style,
      maxLines: widget.isLong ? 5 : 1,
      cursorColor: paletteColors.active,
      obscureText: isObscureText,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      decoration: InputDecoration(
        hintText: translate(widget.hint ?? ''),
        focusedBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            width: Dimens.borderThickness,
            color: paletteColors.active,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: _borderRadius,
          borderSide: BorderSide(
            width: Dimens.borderThickness,
            color: paletteColors.primary,
          ),
        ),
        suffixIcon: widget.isObscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscureText = !isObscureText;
                  });
                },
                icon: Icon(
                  isObscureText ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                  size: Dimens.iconBase,
                  color: paletteColors.textSubtitle,
                ))
            : null,
      ),
      onChanged: widget.onChanged,
    );
  }
}
