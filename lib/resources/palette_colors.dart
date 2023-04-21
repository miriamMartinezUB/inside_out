import 'package:flutter/material.dart';

class PaletteColors {
  Color primary = const Color(0xff28d0b5);
  Color secondary = const Color(0xff9df0e5);
  Color active = const Color(0xfff3b4fa);
  late Color background;
  late Color text;
  late Color textSubtitle;
}

class PaletteColorsLight extends PaletteColors {
  PaletteColorsLight() {
    background = const Color(0xfff3edf5);
    text = const Color(0xff313047);
    textSubtitle = const Color.fromRGBO(49, 48, 71, .6);
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
  static const MaterialColor primary = MaterialColor(0xff28d0b5, {
    50: Color.fromRGBO(40, 208, 181, .1),
    100: Color.fromRGBO(40, 208, 181, .2),
    200: Color.fromRGBO(40, 208, 181, .3),
    300: Color.fromRGBO(40, 208, 181, .4),
    400: Color.fromRGBO(40, 208, 181, .5),
    500: Color.fromRGBO(40, 208, 181, .6),
    600: Color.fromRGBO(40, 208, 181, .7),
    700: Color.fromRGBO(40, 208, 181, .8),
  });
}
