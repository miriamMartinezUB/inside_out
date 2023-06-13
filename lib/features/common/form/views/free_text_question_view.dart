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
  final bool readOnly;
  final bool canCopyAndPaste;
  final bool isObscureText;
  final int? maxLength;
  final int? minLines;

  const FreeTextQuestionView({
    Key? key,
    required this.onChanged,
    required this.isObscureText,
    required this.initialText,
    required this.hint,
    required this.readOnly,
    required this.isLong,
    required this.maxLength,
    required this.minLines,
    required this.canCopyAndPaste,
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
      enableInteractiveSelection: widget.canCopyAndPaste,
      controller: _controller,
      style: style,
      scrollPhysics: const BouncingScrollPhysics(),
      maxLines: widget.isLong ? widget.minLines ?? 5 : 1,
      cursorColor: paletteColors.active,
      obscureText: isObscureText,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      decoration: InputDecoration(
        hintText: translate(widget.hint ?? ''),
        hintStyle: style,
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
