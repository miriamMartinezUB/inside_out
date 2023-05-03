import 'package:flutter/material.dart';

class PaletteColors {
  Color primary = const Color(0xffED7354);
  Color secondary = const Color.fromRGBO(237, 115, 84, 57);
  Color active = const Color(0xfff3b4fa);
  Color textAppBar = const Color(0xfff3edf5);
  Color textButton = const Color(0xfff3edf5);
  Color textError = Colors.red.shade400;
  Color icons = const Color(0xfff3edf5);
  Color card = const Color(0xfff3edf5);
  Color shadow = const Color.fromRGBO(237, 115, 84, 150);
  late Color background;
  late Color text;
  late Color textSubtitle;
}

class PaletteColorsLight extends PaletteColors {
  PaletteColorsLight() {
    background = const Color(0xffFFF2EF);
    text = const Color(0xff313047);
    textSubtitle = const Color(0xff5F5F5F);
  }
}

class PaletteColorsDark extends PaletteColors {
  PaletteColorsDark() {
    background = const Color(0xff313047);
    text = const Color(0xfff3edf5);
    textSubtitle = const Color.fromRGBO(243, 237, 245, .6);
  }
}

class PaletteMaterialColors {
  static const MaterialColor primary = MaterialColor(0xffED7354, {
    50: Color.fromRGBO(237, 115, 84, .1),
    100: Color.fromRGBO(237, 115, 84, .2),
    200: Color.fromRGBO(237, 115, 84, .3),
    300: Color.fromRGBO(237, 115, 84, .4),
    400: Color.fromRGBO(237, 115, 84, .5),
    500: Color.fromRGBO(237, 115, 84, .6),
    600: Color.fromRGBO(237, 115, 84, .7),
    700: Color.fromRGBO(237, 115, 84, .8),
  });
}
